Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbSA2Wkf>; Tue, 29 Jan 2002 17:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285273AbSA2WkP>; Tue, 29 Jan 2002 17:40:15 -0500
Received: from www.transvirtual.com ([206.14.214.140]:25102 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S285352AbSA2WkG>; Tue, 29 Jan 2002 17:40:06 -0500
Date: Tue, 29 Jan 2002 14:39:26 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Mike Paul <mbp2@Lehigh.EDU>
cc: rubini@vision.unipv.it, linux-kernel@vger.kernel.org
Subject: Re: Small kernel patch for Logitech iTouch
In-Reply-To: <20020129222823.GA8154@schala>
Message-ID: <Pine.LNX.4.10.10201291438450.29648-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The current discussion about dealing with patch integration in Linux has
> reminded me of this little patch I wrote a few months back for my Logitech
> iTouch cordless keyboard.  It's mainly to put an end to the "unknown scancode"
> messages that would appear on the console every few minutes and corrupt my
> display, but while I was at it I added keycodes for the special-function
> buttons on the keyboard too.
> 
> Here's the patch, and it's a pretty straightforward one.  It should apply
> cleanly to 2.4.17.

Can you give the DJ tree a try. We have replaced pc_keyb.c with the new
input api drivers for PS/2 devices.

