Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVBCQD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVBCQD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVBCQD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:03:57 -0500
Received: from ida.rowland.org ([192.131.102.52]:6660 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263720AbVBCQDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:03:31 -0500
Date: Thu, 3 Feb 2005 11:03:29 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
cc: mdharm-usb@one-eyed-alien.net, <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B301B3CD73@scl-exch2k.phoenix.com>
Message-ID: <Pine.LNX.4.44L0.0502031056560.1125-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Aleksey Gorelov wrote:

> Hi Matt, Alan, 
> 
>   Could you please tell me (link would do) why it makes default
> delay_use=5 
> really necessary (from the patch below)?
> https://lists.one-eyed-alien.net/pipermail/usb-storage/2004-August/00074
> 7.html
> 
> It makes USB boot really painfull and slow :(
> 
>   I understand there should be a good reason for it. I've tried to find
> an answer in 
> archives, without much success though.

Lots of devices don't need that delay, but enough of them do that we 
decided to add it.  The value of 5 seconds was more or less arbitrary; it 
was long enough for every device we could test and it didn't seem _too_ 
long.  Maybe 1 second would be long enough -- we just didn't know so we 
were conservative.

Alan Stern

