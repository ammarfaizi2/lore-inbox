Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316445AbSEORO3>; Wed, 15 May 2002 13:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSEORO3>; Wed, 15 May 2002 13:14:29 -0400
Received: from imail.ricis.com ([64.244.234.16]:55564 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S316445AbSEORO2>;
	Wed, 15 May 2002 13:14:28 -0400
Date: Wed, 15 May 2002 12:14:43 -0500
Message-Id: <200205151214.AA22282484@imail.ricis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "lee Leahu " <lee@ricis.com>
Reply-To: <lee@ricis.com>
To: <linux-kernel@vger.kernel.org>
Subject: please help with pppoe
X-Mailer: <IMail v7.10>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

by now i am very frusterated because i'm not sure whats going on and i don't have any clue on whats required to fix this.

i'm trying to get pppoe to work from linux.  i already have it working from windows nt and windows xp.

i am running suse 7.3 professional.
my kernel is 2.4.16-4gb (k_deflt made by suse)

i have these packages installed
smpppd-0.49-7 (and yes, smpppd is running)
ppp-2.4.1-170
rp-pppoe-3.4-1

my /etc/ppp/options file goes like this:

hide-password
lock
local
nocrtscts
sync
noauth
noaccomp
mtu 1484
mru 1484
noipdefault
noipx
novj
novjccomp
debug
username "(username)@covad.net"


my /etc/ppp/pap-secret is like this

"(username)@covad.net"     *      "(password)"


i have been trying to get this pppoe to work by running:
pppoe -I eth1
pppoe -D -d 9 -I eth1
adsl-start

please help

lee leahu
lee@ricis.com

