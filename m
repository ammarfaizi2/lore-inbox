Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbRBCWtY>; Sat, 3 Feb 2001 17:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129699AbRBCWtO>; Sat, 3 Feb 2001 17:49:14 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:49829 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129044AbRBCWs6>; Sat, 3 Feb 2001 17:48:58 -0500
Message-ID: <3A7C8AC4.D3CAAF57@Home.net>
Date: Sat, 03 Feb 2001 17:48:36 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PS hanging in 2.4.1 - HAPPENING NOW!!!
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[root@coredump spstarr]# killall -9 gnomeicu

... waiting...

spstarr     67 -bash            read_chan
root        68 /sbin/mingetty t read_chan
root        69 /sbin/mingetty t read_chan
root        73 inetd            do_select
root        74 xfs              do_select
spstarr     83 -bash            wait4
daemon     561 named -u daemon  rt_sigsuspend
daemon     562 named -u daemon  do_poll
daemon     563 named -u daemon  rt_sigsuspend
daemon     564 named -u daemon  nanosleep
daemon     565 named -u daemon  do_select
root     26231 ./a.out          wait_for_connect
spstarr   9297 /bin/sh /usr/X11 wait4
spstarr   9300 xinit /usr/X11R6 wait4
root      9301 X :0             do_select
spstarr   9303 gnome-session    do_poll
spstarr   9309 esd -terminate - down_interruptible
spstarr   9311 gnome-smproxy -- do_select
spstarr   9325 /usr/local/bin/s do_select
spstarr   9327 panel --sm-confi do_poll
spstarr   9329 gnome-name-servi do_poll
spstarr   9332 tasklist_applet  do_poll
spstarr   9334 quicklaunch_appl unix_stream_data_wait

[root@coredump /root]# uptime
  5:45pm  up 4 days,  7:04,  4 users,  load average: 3.37, 1.81, 0.92

Huh??/ why is my load average gone up?!?

the load average just went crazy..

uname -a
Linux coredump 2.4.1 #1 Tue Jan 30 10:21:42 EST 2001 i586 unknown

Help, I forgot the small script Linus made to see the /proc values:

XMMS *WAS* running at the time of this lock. Im waiting further
instructions.

Shawn.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
