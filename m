Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312826AbSC0LXW>; Wed, 27 Mar 2002 06:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312990AbSC0LXM>; Wed, 27 Mar 2002 06:23:12 -0500
Received: from web13302.mail.yahoo.com ([216.136.175.38]:35855 "HELO
	web13302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312826AbSC0LWx>; Wed, 27 Mar 2002 06:22:53 -0500
Message-ID: <20020327112252.18647.qmail@web13302.mail.yahoo.com>
Date: Wed, 27 Mar 2002 12:22:52 +0100 (CET)
From: =?iso-8859-1?q?Joerg=20Pommnitz?= <pommnitz@yahoo.com>
Subject: Re: I want my martians
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, papiraki@cilys.com
In-Reply-To: <20020322224019.A3252@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Emmanuel Papirakis" <papiraki@cilys.com>

 > echo 0 > /proc/sys/net/ipv4/conf/eth0/rp_filter
 > 
 > (You want to disable reverse-path filtering.)
 > 
 > And maybe:
 > 
 > echo 0 > /proc/sys/net/ipv4/conf/eth0/log_martians
 > 
 >             Papi

"Vojtech Pavlik" <vojtech@suse.cz>

 > 
 > for a in /proc/sys/net/ipv4/conf/*/rp_filter; do echo 0 > $a; done
 > 

I tried this before. It does not help for packets destined for the
same host.

Regards
  Jörg

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Ihre E-Mail noch individueller? - http://domains.yahoo.de
