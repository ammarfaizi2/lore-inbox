Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbQJaQFR>; Tue, 31 Oct 2000 11:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129809AbQJaQE5>; Tue, 31 Oct 2000 11:04:57 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:18963 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129797AbQJaQEy>; Tue, 31 Oct 2000 11:04:54 -0500
Message-ID: <39FEED01.4B7D5D93@holly-springs.nc.us>
Date: Tue, 31 Oct 2000 11:02:09 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geoff Winkless <geoff@farmline.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.17 & VM: do_try_to_free_pages failed / eepro100
In-Reply-To: <069c01c0434b$ad0c5a50$1400000a@farmline.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a similar message with my 2.2.16 kernel:

Oct 23 15:02:12 cartman kernel: VM: do_try_to_free_pages failed for
kswapd... 
Oct 23 15:02:12 cartman kernel: VM: do_try_to_free_pages failed for
klogd... 
Oct 23 15:02:13 cartman kernel: VM: do_try_to_free_pages failed for
nmbd... 
Oct 23 15:02:13 cartman kernel: VM: do_try_to_free_pages failed for
httpd... 
Oct 24 14:24:23 cartman kernel: VM: do_try_to_free_pages failed for X... 
Oct 24 14:24:23 cartman kernel: VM: do_try_to_free_pages failed for
httpd... 
Oct 24 14:24:23 cartman kernel: VM: do_try_to_free_pages failed for
netscape-commun... 
Oct 24 14:24:24 cartman kernel: VM: do_try_to_free_pages failed for
mixer_applet... 
Oct 24 14:24:24 cartman kernel: VM: do_try_to_free_pages failed for
multiload_apple... 
Oct 24 14:24:24 cartman kernel: VM: do_try_to_free_pages failed for
xntpd... 
Oct 24 15:55:43 cartman kernel: VM: do_try_to_free_pages failed for
vmware... 
Oct 24 15:55:43 cartman kernel: VM: do_try_to_free_pages failed for
geyes_applet... 
Oct 24 17:33:58 cartman kernel: VM: do_try_to_free_pages failed for
deskguide_apple... 
Oct 24 17:33:58 cartman kernel: VM: do_try_to_free_pages failed for
xscreensaver... 
Oct 24 17:33:58 cartman kernel: VM: do_try_to_free_pages failed for
xntpd... 
Oct 24 17:33:58 cartman kernel: VM: do_try_to_free_pages failed for
mixer_applet... 
Oct 24 17:33:58 cartman kernel: VM: do_try_to_free_pages failed for
gnomeicu... 
Oct 24 17:33:59 cartman kernel: VM: do_try_to_free_pages failed for
httpd... 
Oct 25 15:55:20 cartman kernel: VM: do_try_to_free_pages failed for
xntpd... 
Oct 27 12:37:24 cartman kernel: VM: do_try_to_free_pages failed for
xmms... 
Oct 27 12:37:24 cartman kernel: VM: do_try_to_free_pages failed for
gnomeicu... 
Oct 27 12:37:24 cartman kernel: VM: do_try_to_free_pages failed for
xntpd... 
Oct 27 12:37:24 cartman kernel: VM: do_try_to_free_pages failed for
xmms... 
Oct 27 14:29:28 cartman kernel: VM: do_try_to_free_pages failed for X... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
mixer_applet... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
xntpd... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
mini_commander_... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
xscreensaver... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
xmms... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
xmms... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
httpd... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
xntpd... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
gpm... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
identd... 
Oct 27 14:29:30 cartman kernel: VM: do_try_to_free_pages failed for
init... 
Oct 27 14:29:32 cartman kernel: VM: do_try_to_free_pages failed for
mozilla-bin... 
Oct 27 14:29:32 cartman kernel: VM: do_try_to_free_pages failed for
xntpd... 
Oct 27 17:29:56 cartman kernel: VM: do_try_to_free_pages failed for
xscreensaver... 


... notice the "kswapd" and "klogd" at the top.

-M

Geoff Winkless wrote:
> 
> Hi
> 
> Searching through the archives I found this post on Tue, Sep 12, 2000 at
> 09:41:13PM +0200 from Octave Klaba
> 
> > Hello,
> > On a high load server, kernel has some errors:
> >
> > VM: do_try_to_free_pages failed for httpd...
> > VM: do_try_to_free_pages failed for httpd...
> > eth0: Too much work at interrupt, status=0x4050.
> > eth0: Too much work at interrupt, status=0x4050.
> >
> > is there somewhere the new version of driver for eepro100
> > to make a test ?
> 
> I'm wondering if anyone has found a solution for this: our mailserver is
> exhibiting the same error message (although no mention of the eth0
> interface, we do also use the eepro100):
> 
> Oct 31 12:12:14 mail-client kernel: VM: do_try_to_free_pages failed for
> sendmail
> ...
> Oct 31 12:12:14 mail-client last message repeated 2 times
> Oct 31 12:12:14 mail-client kernel: VM: do_try_to_free_pages failed for
> in.pop3d
> ...
> Oct 31 12:12:14 mail-client kernel: VM: do_try_to_free_pages failed for
> klogd...
> 
> Oct 31 12:12:23 mail-client last message repeated 14 times
> Oct 31 12:12:23 mail-client kernel: VM: do_try_to_free_pages failed for
> sendmail
> ...
> Oct 31 12:12:23 mail-client last message repeated 15 times
> Oct 31 12:12:23 mail-client kernel: VM: do_try_to_free_pages failed for
> syslogd.
> ..
> Oct 31 12:12:23 mail-client last message repeated 11 times
> Oct 31 12:12:23 mail-client kernel: VM: do_try_to_free_pages failed for
> in.pop3d
> ...
> Oct 31 12:12:23 mail-client last message repeated 15 times
> Oct 31 12:12:23 mail-client kernel: VM: do_try_to_free_pages failed for
> sendmail
> ...
> Oct 31 12:12:24 mail-client last message repeated 30 times
> Oct 31 12:12:24 mail-client kernel: VM: do_try_to_free_pages failed for
> kupdate.
> ..
> Oct 31 12:12:24 mail-client kernel: VM: do_try_to_free_pages failed for
> sendmail
> ...
> Oct 31 12:12:25 mail-client last message repeated 42 times
> Oct 31 12:12:25 mail-client kernel: VM: do_try_to_free_pages failed for
> kupdate.
> ..
> Oct 31 12:12:25 mail-client kernel: VM: do_try_to_free_pages failed for
> sendmail
> ...
> Oct 31 12:12:26 mail-client last message repeated 60 times
> Oct 31 12:12:26 mail-client kernel: VM: do_try_to_free_pages failed for
> kupdate.
> 
> ... etc etc
> 
> To agree with Octave, this only appears to happen under load - over weekends
> (our quiet periods) the syslog is nearly empty. In extremis it has been
> necessary to reboot the machine by kicking the power button.
> 
> Any thoughts appreciated.
> 
> Running Redhat 6.2 (not my choice) on a single-processor PIII-650 with 128MB
> RAM and 256MB swap. Load average is usually around the 0.3 mark. Kernel
> (2.2.17) was compiled from source.
> 
> I'm not subscribed to the list, but I guess this is the only way to find an
> answer - can you please copy me in on any replies. Thanks :0
> 
> Geoff
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
