Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281578AbRKRW4W>; Sun, 18 Nov 2001 17:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281579AbRKRW4N>; Sun, 18 Nov 2001 17:56:13 -0500
Received: from dsl-65-185-241-169.telocity.com ([65.185.241.169]:42626 "HELO
	mail.temp123.org") by vger.kernel.org with SMTP id <S281578AbRKRWz7>;
	Sun, 18 Nov 2001 17:55:59 -0500
Date: Sun, 18 Nov 2001 17:55:53 -0500
From: Faux Pas III <fauxpas@temp123.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Maestro 2E vs. Power mgmt
Message-ID: <20011118175553.A18245@temp123.org>
In-Reply-To: <20011115120314.A11264@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011115120314.A11264@temp123.org>; from fauxpas@temp123.org on Thu, Nov 15, 2001 at 12:03:14PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another interesting finding here... whenever something else is
generating a lot of interrupts (specifically, those devices that
share IRQ 11 with the sound card), the sound actually comes out
correctly, or at least more correctly... still slow.

I noticed this at first while folding up a mozilla window in
windowmaker, I assume the X-server is interrupting on the 
video card a lot there.  hdparm -t /dev/hda also causes it.

-- 
Josh Litherland (fauxpas@temp123.org)
