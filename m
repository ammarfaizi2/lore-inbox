Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273944AbRIRVoB>; Tue, 18 Sep 2001 17:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273945AbRIRVnl>; Tue, 18 Sep 2001 17:43:41 -0400
Received: from mail.missioncriticallinux.com ([208.51.139.18]:14866 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S273944AbRIRVnh>; Tue, 18 Sep 2001 17:43:37 -0400
Message-ID: <3BA7C01E.82613672@MissionCriticalLinux.com>
Date: Tue, 18 Sep 2001 14:43:58 -0700
From: Bruce Blinn <blinn@MissionCriticalLinux.com>
Organization: Mission Critical Linux
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.6-cdrom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <Pine.LNX.3.95.1010918124738.22153A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Tue, 18 Sep 2001, Bruce Blinn wrote:
> 
> > "Richard B. Johnson" wrote:
> > >
> > > Okay. That's good. The guy that asked to get the image to find out what
> > > was happening can probably use a small piece of that to find out what
> > > is going on. It probably is a CD data + Music image where the first
> > > readable stuff is data, followed by a music image.
> > >
> > > You can try cdda2wav -D0,4,0, -B. You will probably get some *.wav files.
> > >
> 

I downloaded a copy of cdda2wav and was able to run it.  Here is the
output:

# cdda2wav -D0,0,0 -B
Type: ROM, Vendor 'Lite-On ' Model 'LTN483S 48x Max ' Revision 'PD02'
cdda2wav:
Warning: controller returns wrong size for CD capabilities page.
MMC+CDDA
724992 bytes buffer memory requested, 4 buffers, 75 sectors
#Cdda2wav version 1.11a07_linux_2.4.6-cdrom_i686_i686 real time sched.
soundcard support
 DATAtrack recorded      copy-permitted tracktype
      1- 1 uninterrupted            yes      data
 DATAtrack recorded      copy-permitted tracktype
      2- 2   incremental             no      data
Table of Contents: total tracks:2, (total time 3:10.44)
  1.[ 0:06.62],  2.[ 3:01.57],
 
Table of Contents: starting sectors
  1.(       0),  2.(     512), lead-out(   14144)
CDINDEX discid: 9hOr8JVIL3ybrw8DyqAsew8V_MM-
CDDB discid: 0x0a00bc02
CD-Text: not detected
CD-Extra: not detected
This disk has no audio tracks
