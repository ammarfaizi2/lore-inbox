Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269662AbUJHAVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269662AbUJHAVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269886AbUJGW57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:57:59 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:18185 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S269876AbUJGWqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:46:47 -0400
Date: Fri, 8 Oct 2004 00:46:40 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: mmap specification - was: ... select specification
Message-ID: <20041007224640.GC7047@pclin040.win.tue.nl>
References: <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156727.31753.44.camel@localhost.localdomain> <001f01c4ac8b$35849710$161b14ac@boromir> <1097160628.31614.68.camel@localhost.localdomain> <20041007215834.GA7047@pclin040.win.tue.nl> <CE341A74-18B0-11D9-ABEB-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE341A74-18B0-11D9-ABEB-000393ACC76E@mac.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 06:32:43PM -0400, Kyle Moffett wrote:

>>>"References within the address range starting at pa and continuing
>>> for len bytes to whole pages following the end of an object shall
>>> result in delivery of a SIGBUS signal."
> 
> The last bit of the SuS text means:
> 
> pa <-- len --> eof <-> page boundary
> 
> Anywhere from pa to page boundary will generate SIGBUS.

The POSIX text is clear to me, and Linux is compliant.
On the other hand, I have no idea what you try to say.

Andries
