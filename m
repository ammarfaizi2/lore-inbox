Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTFOTpy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTFOTpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:45:53 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:5813 "EHLO
	jumper") by vger.kernel.org with ESMTP id S262820AbTFOTpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 15:45:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi>
	<20030615191125.I5417@flint.arm.linux.org.uk>
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Sun, 15 Jun 2003 23:00:00 +0300
In-Reply-To: <20030615191125.I5417@flint.arm.linux.org.uk> (Russell King's
 message of "Sun, 15 Jun 2003 19:11:25 +0100")
Message-ID: <87el1vcdrz.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Russell King <rmk@arm.linux.org.uk> writes:

> On Sun, Jun 15, 2003 at 08:50:49PM +0300, Jaakko Niemi wrote:
>>  I seem to be able to reproduce crash with 2.7.70-bk and .71.
>>  First, I tried getting dlink dwl-650 wlan card up on my thinkpad
>>  570e, but orinoco_cs does not seem to want to even look at it.
>>  (any ideas what's the deal with that, btw?) 
>
> What happens if you plug in your cardbus card before the dlink wlan card?

 Same thing.

> If that doesn't work, please repeat your procedure to cause the oops.

 If I boot without the card, I don't seem to be able to get any
 packets out at all, but if I boot with the card inserted, the
 driver loads normally and I can get the interface up. Still, if
 I remove it and reinsert few times, crash happens. 
 
 Looks like I now get repeatedly the oops when removing the
 card for the second time.

> In either case, could you send the output of lspci -vv at the
> following points:
>
> - directly after boot

 lspci1.boot

> - after you insert the cardbus card

 lspci2.inserted
 lspci3.driver is after installing the driver

> - after you remove it

 lspci4.removed
 lspci5.reinserted is after reinsert

> - after you re-insert (and get the oops)

 lspci segfaults after the oops.

 dmesg.out and dmes.out.ksymoops have the latest oops.


                     --j


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=oopsen.tar.gz
Content-Transfer-Encoding: base64

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
OisfG2mFzh8Xnc0HoNP8k6PzW5c+1fXsZv3fqvppiNh47D7uqv+bVn29/s8sS9X/v8al6v+q/q/q
/6r+r+r/30k9VNX/Vf3/Z8K7qv+r+r+q/6v6v6r/q/q/qv+r+r+q/6v6v6r/q/q/qv+r+r+q/39J
hfXrbx88angGW80VTTCc4sN9NOGuYwKPcTbghyy5Krj+YHBt3heudx0W+CHh+q2Loz/BtVr/t6sp
gurisb/+/4Dff8ZwoaHq/1/jUvV/Vf9X9X9V/1f1/++kHqrq/6r+/zPhXdX/v87vP6v6v6r/q/q/
qv+r+r+q/6v6//ctR1X/V/V/Vf9X9X9V///e6//fevv+i6/V+k+9mvKn+AXoB/z+c0PVf77Opeo/
qv6j6j+q/qPqP9/Jfriq/6j6z8+Ed1X/Ud//VPUfVf9R9R9V/1H1H1X/UfUfVf9R9R9V/1H1H1X/
+f7rP9/zF+p+rl/YVb//rND5/aJT/f7zn7B2/me4Vuv/TjXl+hN8BfTT9X9xrdf/646q/3+Vq1h/
f8qz8ypas6fo447zHw38t1z/Rv0Z7e/WDbX+X+N6Hcbzq6VDqNarDQOdfJLkf//XfDrjKeZj5563
oLCqFmzt81Hoxtvb8BcDsjlMePZ///43GHUwdltst2XtwsHB8ITSW0t7G/o8gWnic3KTIw7zDD1m
gPFByjMMEziEGQSMaZ3emyG6uOQCGXyYja+zEN0FHLf7mP7MWhoIAt40i8rJ6gX66q3dwCPXOc9k
ZeYWRkl1g9GVESEOjKdoA29l5c31Pstd+btYjY+GK6tJdw23pLrJKOcp9sJ8N3dv512fqleITfIe
vR1uZg2C9W7Lqu+NqRq7Rr8Dr9/83j/og3vhhhHNpKq9iTFswXVnuPK5G80w/MDYwN41LEcD2O+3
4UMSc7zDdh0QTzFe7B2+gZGLUU7LQKLiaEhBV2c220TIkPJleD7GAKog3Uim0dbB1PXGVI/0ec49
DN6qIKIUjCjlVjmFdxn485TutAd9QBBGWfUW3n0RgxHpsE/1YNfzeJZxpO/Mw8inBzSgKMxygXkh
D9qjf0UBeURbJ3Q6R5RIW0Bqt1fz+UVt7Ls43BijODcKP1Az3cHpX5g26O3D2M3GkItjHhiZpSLO
M5hpw1aS+hjoGbiCTWPXhNF1zrNtbb8YLdh2s8oaDei//ACoaDTSJK1qGJVnSYTdYxiXzFN55KPJ
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
--=-=-=--
