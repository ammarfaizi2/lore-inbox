Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422708AbWHSBUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbWHSBUj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 21:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWHSBUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 21:20:38 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:22166 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1161055AbWHSBUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 21:20:38 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andreas Steinmetz <ast@domdv.de>, Arjan van de Ven <arjan@infradead.org>,
       Willy Tarreau <w@1wt.eu>, Willy Tarreau <wtarreau@hera.kernel.org>,
       linux-kernel@vger.kernel.org, mtosatti@redhat.com,
       Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Date: Sat, 19 Aug 2006 11:20:22 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <kioce290d37424jk4pedjmiibtc9u2p12n@4ax.com>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de> <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org> <44E42A4C.4040100@domdv.de> <20060817090651.GP7813@stusta.de> <44E433DB.9090501@domdv.de> <20060818232501.GE7813@stusta.de>
In-Reply-To: <20060818232501.GE7813@stusta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006 01:25:01 +0200, Adrian Bunk <bunk@stusta.de> wrote:

>Does anyone have an example with working kernels for both 2.4 and 2.6
>and a significantely bigger functionally equivalent 2.6 kernel?

grant@peetoo:~$ ls -l /boot/bzImage-2.*
-rw-r--r--  1 root root 1138921 2006-07-30 07:18 /boot/bzImage-2.4.30-hf32.7
-rw-r--r--  1 root root 1139045 2006-07-30 06:35 /boot/bzImage-2.4.31-hf32.7
-rw-r--r--  1 root root 1139058 2006-07-30 06:00 /boot/bzImage-2.4.32-hf32.7
-rw-r--r--  1 root root 1138830 2006-08-12 15:55 /boot/bzImage-2.4.33-final
-rw-r--r--  1 root root 1632535 2006-07-29 16:34 /boot/bzImage-2.6.16.27a
-rw-r--r--  1 root root 1644014 2006-08-09 14:48 /boot/bzImage-2.6.17.8a
-rw-r--r--  1 root root 1643932 2006-08-14 05:25 /boot/bzImage-2.6.17.8b
-rw-r--r--  1 root root 1668673 2006-08-09 16:25 /boot/bzImage-2.6.18-rc4a

grant@sempro:~$ ls -l /boot/bzImage-2.*
-rw-r--r--  1 root root 1129330 2006-07-30 07:04 /boot/bzImage-2.4.30-hf32.7
-rw-r--r--  1 root root 1129379 2006-07-30 06:35 /boot/bzImage-2.4.31-hf32.7
-rw-r--r--  1 root root 1129523 2006-07-30 05:46 /boot/bzImage-2.4.32-hf32.7
-rw-r--r--  1 root root 1133768 2006-08-12 15:55 /boot/bzImage-2.4.33-final
-rw-r--r--  1 root root 1783286 2006-07-29 16:34 /boot/bzImage-2.6.16.27a
-rw-r--r--  1 root root 1746301 2006-08-09 14:48 /boot/bzImage-2.6.17.8a
-rw-r--r--  1 root root 1746294 2006-08-14 05:23 /boot/bzImage-2.6.17.8b
-rw-r--r--  1 root root 1795269 2006-08-07 09:33 /boot/bzImage-2.6.18-rc3-mm2a
-rw-r--r--  1 root root 1770411 2006-08-09 16:25 /boot/bzImage-2.6.18-rc4a

grant@silly:~$ ls -l /boot/bzImage-2.*
-rw-r--r--  1 root root 1042781 2006-07-30 07:25 /boot/bzImage-2.4.30-hf32.7
-rw-r--r--  1 root root 1042926 2006-07-30 06:45 /boot/bzImage-2.4.31-hf32.7
-rw-r--r--  1 root root 1042947 2006-07-30 06:04 /boot/bzImage-2.4.32-hf32.7
-rw-r--r--  1 root root 1042782 2006-08-12 15:55 /boot/bzImage-2.4.33-final
-rw-r--r--  1 root root 1417798 2006-07-29 16:34 /boot/bzImage-2.6.16.27a
-rw-r--r--  1 root root 1430140 2006-08-09 14:48 /boot/bzImage-2.6.17.8a
-rw-r--r--  1 root root 1451699 2006-08-09 16:32 /boot/bzImage-2.6.18-rc4a

grant@stinkpad:~$ ls -l /boot/bzImage-2.*
-rw-r--r--  1 root root  795909 2006-07-30 07:08 /boot/bzImage-2.4.30-hf32.7
-rw-r--r--  1 root root  795939 2006-07-30 06:23 /boot/bzImage-2.4.31-hf32.7
-rw-r--r--  1 root root  831636 2006-07-30 05:45 /boot/bzImage-2.4.32-hf32.7
-rw-r--r--  1 root root  831623 2006-08-12 16:25 /boot/bzImage-2.4.33-final
-rw-r--r--  1 root root  831614 2006-07-28 12:08 /boot/bzImage-2.4.33-rc3
-rw-r--r--  1 root root 1155031 2006-07-29 16:33 /boot/bzImage-2.6.16.27a
-rw-r--r--  1 root root 1140869 2006-07-29 14:10 /boot/bzImage-2.6.17.7a
-rw-r--r--  1 root root 1141543 2006-08-09 14:48 /boot/bzImage-2.6.17.8a
-rw-r--r--  1 root root 1767681 2006-08-02 16:17 /boot/bzImage-2.6.18-rc3a [1]
-rw-r--r--  1 root root 1770411 2006-08-09 15:59 /boot/bzImage-2.6.18-rc4a [1]

grant@tosh:~$ ls -l /boot/bzImage-2.*
-rw-r--r--  1 root root 1001949 2006-07-30 07:18 /boot/bzImage-2.4.30-hf32.7
-rw-r--r--  1 root root 1003065 2006-07-30 06:35 /boot/bzImage-2.4.31-hf32.7
-rw-r--r--  1 root root 1001865 2006-07-30 06:01 /boot/bzImage-2.4.32-hf32.7
-rw-r--r--  1 root root 1001815 2006-08-12 15:55 /boot/bzImage-2.4.33-final
-rw-r--r--  1 root root 1758378 2006-07-29 16:34 /boot/bzImage-2.6.16.27a
-rw-r--r--  1 root root 1765996 2006-08-09 14:48 /boot/bzImage-2.6.17.8a
-rw-r--r--  1 root root 1770972 2006-08-09 16:25 /boot/bzImage-2.6.18-rc4a

grant@niner:~$ ls -l /boot/bzImage-2.*
-rw-r--r--  1 root root  849759 2006-07-30 07:21 /boot/bzImage-2.4.30-hf32.7
-rw-r--r--  1 root root  849671 2006-07-30 06:35 /boot/bzImage-2.4.31-hf32.7
-rw-r--r--  1 root root  925166 2006-07-30 06:00 /boot/bzImage-2.4.32-hf32.7
-rw-r--r--  1 root root  925027 2006-08-12 15:55 /boot/bzImage-2.4.33-final
-rw-r--r--  1 root root 1331906 2006-07-29 16:33 /boot/bzImage-2.6.16.27a
-rw-r--r--  1 root root 1340701 2006-08-09 14:49 /boot/bzImage-2.6.17.8a
-rw-r--r--  1 root root 1361000 2006-08-09 16:25 /boot/bzImage-2.6.18-rc4a

Looks like a consistent ~40% bloat to me ;)  

Configs (grep = .config) up on <http://bugsplatter.mine.nu/test/>, very 
similar configs as I dual boot 2.4 / 2.6 for testing.  NICs and vfst/ntfs 
as modules on boxen dual-boot 'doze/linux.

2.6 boots but no longer works properly on box deltree since last couple 
releases, I have no desire to take the firewall box down to discover why 
2.6 no longer does networking like it used to.  2.6 leaving old hardware 
behind, who cares?  Is why I stay with 2.4 on older hardware.

[1] fails to boot, locks up just after lilo, too early in boot to gain 
any clues at all :(  IBM 365X early model, usually runs win98, an orphan?

Grant.
