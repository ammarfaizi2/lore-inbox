Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280229AbRJaODG>; Wed, 31 Oct 2001 09:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280224AbRJaOC5>; Wed, 31 Oct 2001 09:02:57 -0500
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.9]:6849 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S280219AbRJaOCu>; Wed, 31 Oct 2001 09:02:50 -0500
Date: Wed, 31 Oct 2001 09:01:10 -0500
From: Les Schaffer <schaffer@optonline.net>
Subject: Re: 2.4.13 (SMP): kswapd working furiously, to no effect
In-Reply-To: <Pine.LNX.4.21.0110310744220.4528-100000@freak.distro.conectiva>
To: linux-kernel@vger.kernel.org
Message-id: <87elnjnc2h.fsf@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (artichoke)
In-Reply-To: <15325.64751.75250.887741@gargle.gargle.HOWL>
 <Pine.LNX.4.21.0110310744220.4528-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please try the newest .14-pre.

will run pre6 all day today and then post results in the evening when
the problems usually happen.

however, i am pushing on it now, several Matlab (4) and Netscape (10)
and xemacs (17) sessions open, and kswapd seems very quiet and system
is very responsive, so things look very good. 

les



 08:50:24 up 16 min,  2 users,  load average: 0.44, 0.37, 0.23
179 processes: 178 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:   1.2% user,   6.2% system,   0.0% nice,  92.6% idle
Mem:    513920K total,   510980K used,     2940K free,     2892K buffers
Swap:   506036K total,     4140K used,   501896K free,    93564K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  300 root       6 -10  232M  56M  6164 S <   1.3 11.1   0:21 XFree86
10036 godzilla  13   5 44668  42M  9388 S N   0.0  8.4   0:04 matlab
10037 godzilla  12   5 44668  42M  9388 S N   0.0  8.4   0:00 matlab
10038 godzilla  15   9 44668  42M  9388 S N   0.0  8.4   0:00 matlab
10039 godzilla  15  10 44668  42M  9388 S N   0.0  8.4   0:00 matlab
10040 godzilla  13   5 44668  42M  9388 S N   0.0  8.4   0:00 matlab
10041 godzilla  13   5 44668  42M  9388 S N   0.0  8.4   0:01 matlab
10042 godzilla  13   5 44668  42M  9388 S N   0.0  8.4   0:00 matlab
10043 godzilla  13   5 44668  42M  9388 S N   0.0  8.4   0:00 matlab
10045 godzilla  13   5 44668  42M  9388 S N   0.0  8.4   0:00 matlab
10046 godzilla  13   5 44668  42M  9388 S N   0.0  8.4   0:00 matlab

    5 root       9   0     0    0     0 SW    0.0  0.0   0:00.13 kswapd
