Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131149AbRBPURn>; Fri, 16 Feb 2001 15:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131168AbRBPURe>; Fri, 16 Feb 2001 15:17:34 -0500
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:25609 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S131149AbRBPURZ>; Fri, 16 Feb 2001 15:17:25 -0500
Message-ID: <3A8D8A23.97737A12@damncats.org>
Date: Fri, 16 Feb 2001 15:14:27 -0500
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Wood <dwood@templar.com>
CC: James Simmons <jsimmons@linux-fbdev.org>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: virtual console corruption (2.4.1/p4/radeon/XFree864.0.2)
In-Reply-To: <Pine.LNX.4.30.0102161502020.11598-100000@mail.templar.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wood wrote:
> 
> I believe you, although... why doesn't it happen with 2.2.17? vconsole
> buffers in a different place in memory, I suppose?
> 
> I'll forward this to the XFree team. Thanks!
> -David

Known bug, they're working on it.

If you want to avoid the corruption, use the Vesa framebuffer driver for
the console for the time being, it works fine for the Radeon.

John
