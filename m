Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUHKEva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUHKEva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 00:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267937AbUHKEv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 00:51:29 -0400
Received: from quechua.inka.de ([193.197.184.2]:2539 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S267939AbUHKEvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 00:51:01 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bug zapper?  :)
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200408110030.37601.v13@priest.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Bul4l-00041O-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 11 Aug 2004 06:50:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200408110030.37601.v13@priest.com> you wrote:
> If you have a 1000 lines project and:
> 
> a) Remove all empty lines means that you remove bugs?

No because  LOC  is defined on a more abstract level. It is not about "wc
-l", but there are various methods, and all basically count the number of
statement. Accounting brnaches and nifty shortcuts more than normal
statements. I suggest you read about the "Personal Software Process", it
very well describes the numbers you can get, and the questions they answer
(and especially which numbers are not compareable).

> b) Split it to 5 libraries and 5 utilities (10 projects) means that you'll 
> have less bugs? 

You will most likely add  additional lines, and of course having 5 projects
with 500 lines has not less bugs than 1 project with 2500 loc. BTW: of
course it might make the programs more manageable since it explictely
introduces more boundaries and interfaces. Read some statements from DJB
(Sorry!) on that.


> a) 50 bugs require 10.000 lines
> b) 50 bugs will always exist on 10.000 lines
> c) All the projects out there have the same number of bugs/line

Hmm.. i used to learn the meaning of average at the university, and nobody
claims that those statements are true! Average statstics is good for
benchmarking, and you would be surprised how fairly stable those bug counts
are.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
