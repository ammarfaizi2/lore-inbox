Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVDFHBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVDFHBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVDFHBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:01:53 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:64209 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262124AbVDFHBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:01:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: AMD64 Machine hardlocks when using memset
Date: Wed, 6 Apr 2005 09:02:11 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <3Ojst-4kX-19@gated-at.bofh.it> <3PxjH-812-3@gated-at.bofh.it> <42535FFF.4080503@shaw.ca>
In-Reply-To: <42535FFF.4080503@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504060902.12066.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 6 of April 2005 06:05, Robert Hancock wrote:
> Alan Cox wrote:
> > On Sad, 2005-04-02 at 05:50, Robert Hancock wrote:
> > 
> >>I'm wondering if one does a ton of these cache-bypassing stores whether 
> >>something gets hosed because of that. Not sure what that could be 
> >>though. I don't imagine the chipset is involved with any of that on the 
> >>Athlon 64 - either the CPU or RAM seems the most likely suspect to me
> > 
> > 
> > The glibc version is essentially the "perfect" copy function for the
> > CPU. If you have any bus/memory problems or chipset bugs it will bite
> > you.
> 
> Anyone have any suggestions on how to track this further? It seems 
> fairly clear what circumstances are causing it, but as for figuring out 
> what's at fault..

Well, I would start from changing memory modules.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
