Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317338AbSG1VAk>; Sun, 28 Jul 2002 17:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSG1VAj>; Sun, 28 Jul 2002 17:00:39 -0400
Received: from dclient80-218-19-128.hispeed.ch ([80.218.19.128]:45977 "HELO
	lombi.mine.nu") by vger.kernel.org with SMTP id <S317338AbSG1VAj>;
	Sun, 28 Jul 2002 17:00:39 -0400
Mime-Version: 1.0
Message-Id: <p04320401b96a05f1a59a@[192.168.3.11]>
In-Reply-To: <20020726160742.GA951@ksu.edu>
References: <20020726160742.GA951@ksu.edu>
Date: Sun, 28 Jul 2002 23:02:46 +0200
To: linux-kernel@vger.kernel.org
From: Christian Jaeger <christian.jaeger@sl.ethz.ch>
Subject: Re: How to start on new db-based FS?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's always the possibility to build upon AVFS 
(http://www.inf.bme.hu/~mszeredi/avfs), either using the LD_PRELOAD 
version improved by Frederik Eaton, or the version using the (CODA or 
better the) FUSE kernel module (the latter is still in development 
from what I hear).

We have built a DB backed filesystem for use in a content management 
system (http://www.ethlife.ethz.ch/newcms), based on the AVFS 
LD_PRELOAD version, and embedding perl so we could write the actual 
filesystem implementation in perl. It has required quite a bit of 
labour, but works well for our purpose now. It's GPL'd, but not yet 
polished for publication, so contact me if you're interested.

Christian.
-- 
Christian Jaeger  Programmer & System Engineer
ETHLife CMS Project - www.ethlife.ethz.ch/newcms - www.ethlife.ethz.ch
