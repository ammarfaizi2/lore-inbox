Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264461AbRFXTvb>; Sun, 24 Jun 2001 15:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264468AbRFXTvV>; Sun, 24 Jun 2001 15:51:21 -0400
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:20977 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S264464AbRFXTvJ>;
	Sun, 24 Jun 2001 15:51:09 -0400
To: linux-kernel@vger.kernel.org
Subject: serial ports in 2.4.x
From: Jens Gecius <jens@gecius.de>
Date: 24 Jun 2001 15:51:08 -0400
Message-ID: <87lmmhodw3.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I don't _exactly_ know if this might be an issue for the
kernel. However, I noticed that I used to be able to download pictures
of my digicam (nikon 600) via /dev/ttySx to the box using gphoto 0.4.3
all the time.

At some point, unfortunately I don't recall if it happened while
switching from 2.2.17 to 2.4 at all or within the 2.4.x series, I was
unable to get any connection to my cam (both up and smp, even same
problem on two different systems, one gigabyte vxd7, the other
gigabyte bx). It used to work just fine, so anything changed for
support of serial ports (serial.c claims no)? Maybe anything related
with devfsd, which I switched at the same time as 2.2 to 2.4? Any
other interaction which might have caused this? 

Another symptom is that after I tried to use the port with the digicam
(which failed), the port is unusable. The otherwise working connection
to the palm doesn't work anymore, a reboot is required to get it back
to work.

Speed setting of the port is not the issue right here:
1. it used to work without special settings
2. I tried different speed settings (very slow to 115k)

And, of course, it doesn't work with the original software from nikon
via wine. The orig soft does work under win <argh>.

Nonetheless, the UPS connected to one port via wired wiring (no real
serial protocol used, just certain lines high/low) does work even
after the port was used with the digicam and rendered useless for the
palm.

If any other info is needed, let me know. Unfortunately, I'm currently
unable to boot into 2.2.17 because I'm using devfsd and was not able
to apply that patch correctly on a plain vanilla kernel, but that I'm
not worried about 'cause 2.4.4 runs pretty decent otherwise on both
boxes. 

-- 
Tschoe,                    Get my gpg-public-key here
 Jens                     http://gecius.de/gpg-key.txt
