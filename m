Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTDOROy (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 13:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbTDOROy 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 13:14:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10176
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261819AbTDOROy (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 13:14:54 -0400
Subject: Re: ac97, alc101+kt8235 sound
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benson Chow <blc@q.dyndns.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304151057090.31225-100000@q.dyndns.org>
References: <Pine.LNX.4.44.0304151057090.31225-100000@q.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050424108.27745.77.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 17:28:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 18:09, Benson Chow wrote:
> What's the normal flow to get this added into ac97_codecs.c?
> 
> +        {0x414C4730, "ALC101",             &null_ops},
> 
> Adding this line into the table in ac97_codecs.c (with a few missing
> #defines fixed... then I noticed they're already in -ac1 :) in
> 2.4.21-pre7 made sound work fine.

This really shouldnt make any difference. Does it work without that
patch as well ?


