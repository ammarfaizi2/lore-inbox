Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBQHM5>; Sat, 17 Feb 2001 02:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129072AbRBQHMr>; Sat, 17 Feb 2001 02:12:47 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:10770 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S129065AbRBQHMp>;
	Sat, 17 Feb 2001 02:12:45 -0500
Message-ID: <3A8E2467.FC6FE1B4@sh0n.net>
Date: Sat, 17 Feb 2001 02:12:40 -0500
From: Shawn Starr <Shawn.Starr@sh0n.net>
Organization: sh0n.net - http://www.sh0n.net/spstarr
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: [PROBLEM]: grep hanging with ReiserFS
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 grep -r "216.234.235.46" *


...waiting...

./debugps | more
USER       PID COMMAND          WCHAN
root         1 init             do_select
....
root         7 [kreiserfsd]     -
.....

root     28438 grep -r 216.234. pipe_wait

Im using grep in /etc and its just waiting....
it should have finished.

Shawn.

