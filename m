Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbQKBPo1>; Thu, 2 Nov 2000 10:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129932AbQKBPoR>; Thu, 2 Nov 2000 10:44:17 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:57095 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S129873AbQKBPoD>;
	Thu, 2 Nov 2000 10:44:03 -0500
Date: Thu, 2 Nov 2000 10:44:01 -0500
From: Zach Brown <zab@zabbo.net>
To: Mo McKinlay <mmckinlay@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Maestro3/Allegro: (was ESS device "1998")
Message-ID: <20001102104401.C16000@tetsuo.zabbo.net>
In-Reply-To: <Pine.LNX.4.21.0011021158250.8426-100000@kyle.altai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011021158250.8426-100000@kyle.altai.org>; from mmckinlay@gnu.org on Thu, Nov 02, 2000 at 12:03:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 12:03:41PM +0000, Mo McKinlay wrote:

> I recently obtained an HP Omnibook XE2 laptop. It's a reasonably

As people have mentioned, there is an alpha free driver near
http://www.zabbo.net/maestro3/.  Its not quite up to par yet.  

maybe the web page should talk a bit more about the chip familiy. The
maestro3 has a lot of pieces in common with the maestro2, except for
the part of the chip that did pcm manipulation.  the m3 only has a dsp
where the m2 had specific silicon for doing pcm work.  the allegro
is a "slimmed down" maestro3, and neither have anything to do with
cirrus/crystal CSxxxx parts as far as I know :)

I expect you'll have the 'slow down' problem on the Xe2, we have the
clocking messed up on some implementations (those that don't clock the
thing at 49mhz, as god intended? :))
 
> I've given up on the internal modem (I'm 90% sure it's some kind of

*nod*  Its the usual mc97 codec setup that leaves the hard work for the
processor.  I'm sure one can play around with the dsp on it as well,
but we don't have specs on the dsp's internals.

-- 
 zach
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
