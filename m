Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288593AbSA3Fv3>; Wed, 30 Jan 2002 00:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288595AbSA3FvT>; Wed, 30 Jan 2002 00:51:19 -0500
Received: from lsanca1-ar27-4-63-184-089.vz.dsl.gtei.net ([4.63.184.89]:42925
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S288593AbSA3FvF>; Wed, 30 Jan 2002 00:51:05 -0500
Date: Tue, 29 Jan 2002 21:51:00 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Configure.help in 2.5.3-pre6
Message-ID: <Pine.LNX.4.33.0201292147530.22800-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.5.3-pre6 gets rid of Documentation/Configure.help and replaces it by
smaller files nearer their use. This seems to have broken the help
facility in menuconfig (and possibly the other configs)

I've generated one at config time using a makefile target like this:

Documentation/Configure.help:
        cat `find -name Config.help` > Documentation/Configure.help

Is this the way that it is intended to work, or should I be making extra
effort to not include the .help for the wrong architecture?

Ben
-- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Job Required in Los Angeles - Will do most things unix or IP for money.
http://www.hawaga.org.uk/resume/resume001.pdf
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi

