Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSHIEIg>; Fri, 9 Aug 2002 00:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSHIEIg>; Fri, 9 Aug 2002 00:08:36 -0400
Received: from quechua.inka.de ([212.227.14.2]:33332 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S318141AbSHIEIf>;
	Fri, 9 Aug 2002 00:08:35 -0400
From: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <E17d04X-0000eD-00@starship>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17d18N-0001JZ-00@sites.inka.de>
Date: Fri, 9 Aug 2002 06:12:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E17d04X-0000eD-00@starship> you wrote:
> You would just have to break the patch up again when you submit it.  You
> might want create a patch that demonstrates its usage, by adding some
> asserts to core code and removing comments where the assert makes them
> redundant.

Yes, I defintely thing that those asserts are a good way of documenting
contracts. They can be used to document when a function expects a lock to be
held, and they will also be able to empirical test, if it is true.

It may even help static code analysers to find places where the assertion
macros are missing.

Greetings
Bernd
