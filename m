Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265427AbRFVOJV>; Fri, 22 Jun 2001 10:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265428AbRFVOJL>; Fri, 22 Jun 2001 10:09:11 -0400
Received: from [193.52.92.2] ([193.52.92.2]:17795 "EHLO
	euclide.bretagne.ens-cachan.fr") by vger.kernel.org with ESMTP
	id <S265427AbRFVOI6>; Fri, 22 Jun 2001 10:08:58 -0400
Message-ID: <3B335146.6000403@club-internet.fr>
Date: Fri, 22 Jun 2001 16:08:06 +0200
From: Romain Dolbeau <dolbeaur@club-internet.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre3 ppc; en-US; m18) Gecko/20001110
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>,
        linux fbdev <Linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] fbgen & multiple RGBA
Content-Type: multipart/mixed;
 boundary="------------030007070905020605000201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030007070905020605000201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the attached patch fix a problem with fbgen when changing the
RGBA components but not the depth ; fbgen would not change
the colormap in this case, where it should.

-- 
romain

--------------030007070905020605000201
Content-Type: application/gzip;
 name="fbgen.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fbgen.patch.gz"

H4sICAVHMzsCA2ZiZ2VuLnBhdGNoAIWUXaubQBCGr/VXTO/0+JFokxxIyCFXLS2UQuldKWJ0
TRZkDauGSM+P76yrdjSJFcTd2eed2R1f1vM8yLmob4tU8iuT5eLKU1YssuOJCT/xv//48tn4
ea7hW9xA8ArBavtxtV2vIFwuA9NxnDm18Uly+FoLCEMI1ttwiVotPBzAC5YbdwOO+rzC4WCC
espK1kkF2THiIisiTAMvahTCHqxHi7Ya7rSYiwqYlGRW5OlNstJVg6YfHC8Xt1+JrlxWdZwP
xDhQZFnJqp3pjPd25FXGWZ4qRrK0ZU+SMaHz5zXDPXS7yMCycFO4/7YrUVpEmDK6xtLC14Wk
ELDfQ1JLiUMX2tPatm2CIVlVS6GP1HYsWLtBiC0LNm64antmTM7RlolSXl7yuPmFCX/7WMWn
yE6rmv+rmnsV9u4JjD0powuT0YXfGOKOoZvj6x4+Uf0DiCJn4lSdZxQa6BRt4+erUGSkmq1E
kU6lfu18KUJQzWwhQvQ/Z7bGYEswHiyj6AU/alWZrzMIfNgDRr23dvL+3vt9iDc6jipl26mt
qHoIUrp5RDfPaGWjHhobR2FOjxH79DQJTcmux5TsQpQc2aVnR8F7epJ5FKQ0tcdwPBK7YyeJ
aWzU3EnObm7Dn47RV4u6V5QbLHKR7DpCWUFFvLfkHIsTwzy2+ReA25ss/gUAAA==
--------------030007070905020605000201--

