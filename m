Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWDSSFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWDSSFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWDSSFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:05:51 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:63309 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751131AbWDSSFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:05:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=OACxVcu8YsbBwDI/lMeqvRY8cA3+vcGnP6rZrdpAIqIIFHrbIGBR2msdSviyB/SOcyGeTzRtrkIlB/bQU+ZpVaYjxYARt+AseJiLBIVRgpQjzti79yaBEIH9YsrLYCiaidM0X9B68bnXyX01rUpZ+rAm1mu1qcjCM6dWQRUtf2A=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Diego Calleja'" <diegocg@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.6.17-rc2
Date: Wed, 19 Apr 2006 11:04:47 -0700
Message-ID: <00ad01c663db$bf50d090$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060419200001.fe2385f4.diegocg@gmail.com>
Thread-Index: AcZj25hAeTcoMgjQTdK7mfBjt6rUhwAACJjw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://lwn.net/Articles/178199/ 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Diego Calleja
> Sent: Wednesday, April 19, 2006 11:00 AM
> To: Linus Torvalds
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.6.17-rc2
> 
> Could someone give a long high-level description of what 
> splice() and tee() are? I need a description for 
> wiki.kernelnewbies.org/Linux_2_6_17 (while we're it, it'd be 
> nice if some people can review it in case it's missing 
> something ;) I've named it "generic zero-copy mechanism" but 
> I bet there's a better description, if it's so cool as people 
> says it'd be nice to do some "advertising" of it (notifying 
> people of new features is not something linux has done too 
> well historically :)
> 
> What kind of apps available today could get performance 
> benefits by using this? Is there a new class of "processes" 
> (or apps) that couldn't be done and can be done now using 
> splice, or are there some kind of apps that become too 
> complex internally today because they try to avoid extra copy 
> of data and they can get much simpler by using splice? Why 
> people sees it as a "radical" improvement in some cases over 
> the typical way of doing I/O in Unix. Is this similar or can 
> be compared with ritchie's/SYSV STREAMS?
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

