Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbRGMLYN>; Fri, 13 Jul 2001 07:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbRGMLYC>; Fri, 13 Jul 2001 07:24:02 -0400
Received: from 213.237.41.196.adsl.ynoe.worldonline.dk ([213.237.41.196]:17478
	"HELO dasken.infopoll.org") by vger.kernel.org with SMTP
	id <S267030AbRGMLXq>; Fri, 13 Jul 2001 07:23:46 -0400
Date: Fri, 13 Jul 2001 13:23:47 +0200 (CEST)
From: Hans Schou <chlor@schou.dk>
X-X-Sender: <chlor@dasken.infopoll.org>
To: <linux-kernel@vger.kernel.org>
Subject: #ifdef CONFIG_KCORE - make /proc/kcore optional
Message-ID: <Pine.LNX.4.33L2.0107131320280.1060-100000@dasken.infopoll.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

Is it possible to add a new ifdef which disables /proc/kcore ?

or even better: Only activate it when compiled with -g

Motivation:
* It is useless without -g
  - http://groups.yahoo.com/group/libgtop-devel-list/message/165
* Only kernel hackers uses it
  - "...well, do you, punk?"
* It is a painfull/useless thing for newbies
  - tar cf foo.tar /
* It generates silly questions and answers
  - http://ftp.cobaltnet.com/lists/cobalt-users/msg02754.html


best regards
Hans Schou

