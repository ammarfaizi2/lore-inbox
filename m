Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTEEWlO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTEEWlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:41:14 -0400
Received: from [155.223.251.1] ([155.223.251.1]:26330 "HELO
	gatekeeper.ege.edu.tr") by vger.kernel.org with SMTP
	id S261807AbTEEWlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:41:12 -0400
Date: Tue, 6 May 2003 02:04:25 +0300
From: Halil Demirezen <nitrium@bilmuh.ege.edu.tr>
To: Thomas Horsten <thomas@horsten.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about bios
Message-ID: <20030505230425.GA17060@bilmuh.ege.edu.tr>
References: <20030505225013.GA5375@bilmuh.ege.edu.tr> <Pine.LNX.4.40.0305060041550.7106-100000@jehova.dsm.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0305060041550.7106-100000@jehova.dsm.dk>
User-Agent: Mutt/1.3.28i
X-URL: http://www.pisus.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> What you do in the BIOS does not only disable the BIOS calls for the
> floppy controller, it turns it completely off in the chipset (software
> disconnect) so it is never accessed with the IO access, and therefore is
> not detected.
> 
> It would probably be possible to turn it on again in floppy.c, but it
> would be chipset dependent how to do it.
> 
> Cheers,
> Thomas
> 



So can we say that, during initialization, setup.s pushes some bios info 
to the memory, and then after entering protected mode in i386, it pops
these information and sets kernel depending on it. Because of absence of
FDC controller info at this data area linux does not recognize FDC. However,

I can turn it on still usin IO ports and using in, out assembly instructions.

what i mention above for sure is not correct, however, is the procedure something like that?

thank you..

