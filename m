Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSKMUA4>; Wed, 13 Nov 2002 15:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSKMUA4>; Wed, 13 Nov 2002 15:00:56 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:4527 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262446AbSKMUA4>; Wed, 13 Nov 2002 15:00:56 -0500
Date: Wed, 13 Nov 2002 12:11:01 -0800
From: David Brownell <david-b@pacbell.net>
Subject: 2.5.47bk2 + current modutils == broken hotplug
To: rusty@rustcorp.com.au, kaos <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Message-id: <3DD2B1D5.7020903@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The module-init-tools-0.6.tar.gz utilities (or something
related -- kbuild changes?) break hotplug since they no
longer produce the /lib/modules/$(uname -r)/modules.*map
files as output ... so the hotplug agents don't have the
pre-built database mapping device info to drivers.

What's the plan for getting that back?  (And module.conf
params etc.)  "Changes" says version 2.4.2 is fine, which
appears to be wrong...

- Dave


