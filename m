Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbUBZXrC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUBZXqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:46:49 -0500
Received: from [66.46.92.2] ([66.46.92.2]:3037 "EHLO ns1.superclick.com")
	by vger.kernel.org with ESMTP id S261289AbUBZXq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:46:26 -0500
Subject: Re: Ibm Serveraid Problem with 2.4.25
From: Enrico Demarin <enricod@videotron.ca>
To: Jo Christian Buvarp <jcb@svorka.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <403DB882.9000401@svorka.no>
References: <403DB882.9000401@svorka.no>
Content-Type: text/plain
Message-Id: <1077839333.4823.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 26 Feb 2004 18:48:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same here using the "partially opensource" drivers for a
Promise TX2... no message on 2.4.24.I wonder if it also means it's
corrupting the FS ? :(


- Enrico

On Thu, 2004-02-26 at 04:12, Jo Christian Buvarp wrote:
> Just upgraded my server with the 2.4.25 kernel and I noticed an error :/
> The server is an IBM 345 with a Serveraid 5I controller, when doing an
> dmesg i get this error:
> 
> attempt to access beyond end of device
> 08:05: rw=0, want=528036, limit=528034
> attempt to access beyond end of device
> 08:09: rw=0, want=65208120, limit=65208118
> 
> This error only shows up in 2.4.25, when rebooting to 2.4.24 everything
> looks fine :)
> I tried upgrading the serveraid bios to the newest version (6.11.07),
> but i still got the error.
> 
> So is this an bug in the kernel? Or do I have a problem on my server ?
> Is it safe to run 2.4.25 with this error ? Or should i go back to 2.4.24

