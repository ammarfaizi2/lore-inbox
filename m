Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315857AbSEMGxu>; Mon, 13 May 2002 02:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315858AbSEMGxt>; Mon, 13 May 2002 02:53:49 -0400
Received: from matav-4.matav.hu ([145.236.252.35]:15891 "EHLO
	Forman.fw.matav.hu") by vger.kernel.org with ESMTP
	id <S315857AbSEMGxt>; Mon, 13 May 2002 02:53:49 -0400
Date: Mon, 13 May 2002 08:51:29 +0200 (CEST)
From: Narancs v1 <narancs@narancs.tii.matav.hu>
X-X-Sender: narancs@helka
To: linux-kernel@vger.kernel.org
Subject: net/ipv4/conf/* config order
Message-ID: <Pine.LNX.4.44.0205130845570.2881-100000@helka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

sysctl -a|grep source
net/ipv4/conf/eth2/accept_source_route = 1
net/ipv4/conf/eth1/accept_source_route = 1
net/ipv4/conf/eth0/accept_source_route = 1
net/ipv4/conf/lo/accept_source_route = 1
net/ipv4/conf/default/accept_source_route = 1
net/ipv4/conf/all/accept_source_route = 0

so does it mean, that source routed packets are all dropped in all
interfaces, or does it mean that all accepted?

Yes, I want to disable it, and some other parameters, too, so shall I set
all of them respectively to 0 or 'all' = 0 will do the task?

thanks!

linux 2.4.18

-------------------------
Narancs v1
IT Security Administrator
Warning: This is a really short .sig! Vigyazat: ez egy nagyon rovid szig!


