Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUIOHjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUIOHjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 03:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUIOHjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 03:39:37 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:21961
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262574AbUIOHjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 03:39:35 -0400
Message-ID: <4147F1B4.1060009@ppp0.net>
Date: Wed, 15 Sep 2004 09:39:32 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
References: <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost> <20040915031706.GA909@hockin.org> <20040915034229.GA30747@kroah.com> <20040915044830.GA4919@hockin.org> <20040915050904.GA682@kroah.com> <20040915062129.GA9230@hockin.org> <4147E525.4000405@ppp0.net> <20040915064735.GA11272@hockin.org> <4147E649.1060306@ppp0.net> <20040915065515.GA11587@hockin.org>
In-Reply-To: <20040915065515.GA11587@hockin.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

re-added lkml cc

Tim Hockin wrote:
> Take another example:  ECC.  I'd love to spit out ECC messages in a
> standard way.  I've got some code in devel to do better ECC handling.  But
> you have to spit out the CPU and the address, at least, and possibly more.

Well, time for /sys/devices/memory/memory<n>/. That would perhaps also 
be suitable for numa which want to know which memory module is near 
which cpu. So you could have symbolic links in /sys/devices/cpu/cpu<n> 
to the corresponding memory modules.

Jan
