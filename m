Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSLPWQa>; Mon, 16 Dec 2002 17:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSLPWQa>; Mon, 16 Dec 2002 17:16:30 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:22202 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S261847AbSLPWQ3>; Mon, 16 Dec 2002 17:16:29 -0500
Message-ID: <61DB42B180EAB34E9D28346C11535A78011303BD@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Carlos Fernandez Sanz'" <cfs-lk@nisupu.com>,
       linux-kernel@vger.kernel.org
Subject: RE: NAT helper module for MSN
Date: Mon, 16 Dec 2002 17:24:16 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Is there a help module to help MSN work through a NAT'ed connection?
> 
> If there isn't one, is there an ongoing project to write one 
> I can join? 
> 

This may not be strictly kernel related, are you using masquerading?  I have
yet to have a prob with MSN messenger using 2.2 with ipmasq.  But, have you
checked http://ipmasq.cjb.net/

Here's the masq modules I have loaded.
ip_masq_quake           1420   0  (unused)
ip_gre                  6776   0  (unused)
ip_masq_autofw          2556   0  (unused)
ip_masq_portfw          2636   2
ip_masq_mfw             3272   0
ip_masq_ipsec          11812   0  (unused)
ip_masq_pptp            6856   0
ip_masq_irc             1656   0  (unused)
ip_masq_raudio          3064   0
ip_masq_ftp             2680   0

Maybe you should check withe the iptables group at the netfilter home:
http://www.netfilter.org/

Hope that helps.
Bruce H.
