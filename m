Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbSKCPNf>; Sun, 3 Nov 2002 10:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSKCPNf>; Sun, 3 Nov 2002 10:13:35 -0500
Received: from quechua.inka.de ([193.197.184.2]:15831 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S261972AbSKCPNe>;
	Sun, 3 Nov 2002 10:13:34 -0500
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <1036328263.29642.23.camel@irongate.swansea.linux.org.uk>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E188MXo-00074b-00@sites.inka.de>
Date: Sun, 3 Nov 2002 16:20:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1036328263.29642.23.camel@irongate.swansea.linux.org.uk> you wrote:
> Namespaces is a way to inherit revocation of rights on a large scale (or
> a small one true). #! is a way to handle program specific revocation of
> rights which _is_ filesystem persistent.

#! would be a nice option to increase capabilities on invocation. But the
final target must be linked to the invocation by an entity/revision binding.
Since we do not have modification versions i could think about checksums:

#!#/bin/setcap
10de6c9a339800777c2a8c43a7def924  /bin/ls
+NET_ADMINe

This even will add another integrity checking layer tp the system.

Greetings
Bernd
