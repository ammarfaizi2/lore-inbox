Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbTEHCut (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 22:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTEHCut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 22:50:49 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:38417 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263001AbTEHCus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 22:50:48 -0400
Date: Thu, 8 May 2003 04:03:20 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Felix von Leitner <felix-kernel@fefe.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5: ieee1394 still broken, vesafb still broken, ipv6 still
 broken
In-Reply-To: <20030507235104.GA12486@codeblau.de>
Message-ID: <Pine.LNX.4.44.0305080401440.6566-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   vesafb is told to go to 1024x768-32, does so, but then reads from my
>     TFT display that 1600x1200 is the native resolution and then thinks
>     that is the resolution it is using (even fbset says so).  The result
>     is that I can only see the upper half of my screen, and the display
>     is garbled to boot because the line length is too large, meaning
>     writing something in the right half of the 1600x1200 screen results
>     in overwriting something on the left of my real 1024x768 screen.

The EDID blocks often return the wrong data. The fix for now is to remove 
the edid code. I will passing it to Linus soon.



