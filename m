Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279986AbRKRXTX>; Sun, 18 Nov 2001 18:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280047AbRKRXTN>; Sun, 18 Nov 2001 18:19:13 -0500
Received: from dsl-65-185-241-169.telocity.com ([65.185.241.169]:43394 "HELO
	mail.temp123.org") by vger.kernel.org with SMTP id <S279986AbRKRXTA>;
	Sun, 18 Nov 2001 18:19:00 -0500
Date: Sun, 18 Nov 2001 18:18:59 -0500
From: Faux Pas III <fauxpas@temp123.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maestro 2E vs. Power mgmt
Message-ID: <20011118181859.B18252@temp123.org>
In-Reply-To: <20011118175553.A18245@temp123.org> <E165b3o-0004es-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E165b3o-0004es-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Nov 18, 2001 at 11:09:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2001 at 11:09:12PM +0000, Alan Cox wrote:

> Intriguing - so its as if the sound driver isnt generating interrupts
> (one way to test that would be to monitor /proc/interrupts both with power
> on mains and off of mains)

When playing a particular mp3 with mpg123, the rate of increase of that
field in /proc/interrupts is ~200/sec regardless of whether on AC or
battery.  Of course, doing stuff to the other devices that share that
interrupt blow it up.

-- 
Josh Litherland (fauxpas@temp123.org)
