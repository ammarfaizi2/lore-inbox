Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135549AbRALXq7>; Fri, 12 Jan 2001 18:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135452AbRALXqt>; Fri, 12 Jan 2001 18:46:49 -0500
Received: from ppp13-pool1c.bham.zebra.net ([209.12.6.204]:1152 "HELO
	bliss.penguinpowered.com") by vger.kernel.org with SMTP
	id <S135549AbRALXqd>; Fri, 12 Jan 2001 18:46:33 -0500
Date: Fri, 12 Jan 2001 17:38:11 -0600
From: "Forever shall I be." <zinx@magenet.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.0-ac8 PS/2 mouse woes
Message-ID: <20010112173811.A618@bliss.zebra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-GPG-Fingerprint: 1A27 513C 33D0 4DB6 BBDD  E891 4E64 FCAA 7455 8D71
X-GPG-Public-Key: http://pgp5.ai.mit.edu:11371/pks/lookup?op=get&search=0x74558D71
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just booted to 2.4.0-ac8 (from 2.4.0-ac6) and noticed the mouse was
going rather slow in X, so I pumped up the "Resolution" a bit more and
restarted it.. Didn't help, and when I exited the kernel gave a nice
big OOPS in kapm-idled (sorry, i don't have the output), and don't
know if it's related to the mouse problem, but I do know the mouse
problem goes away when I back out the changes in the ac8 patch to
pc_keyb.c..   I also have the cuecat patch applied, and use it over
the PS/2 mouse port, but I don't think it's interfering..  I doubt
this will be noticable to people not using the "Resolution" option to
speed up the mouse, and mine's rather insane:

(zinx@bliss)/etc/X11$ cat XF86Config | grep Resolution
    Option "Resolution" "50000"

Anyway, just letting you know, and very sorry for the lack of
information..

-- 
Zinx Verituse                           (See headers for gpg key info)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
