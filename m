Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268680AbTCCSFc>; Mon, 3 Mar 2003 13:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268684AbTCCSFc>; Mon, 3 Mar 2003 13:05:32 -0500
Received: from h-64-105-34-204.SNVACAID.covad.net ([64.105.34.204]:16546 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S268680AbTCCSFb>; Mon, 3 Mar 2003 13:05:31 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 3 Mar 2003 10:15:52 -0800
Message-Id: <200303031815.KAA03000@adam.yggdrasil.com>
To: andrew@walrond.org
Subject: Re: Patch: 2.5.62.4 small devfs
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Could you suggest a simple bit of sh script that will tell me if I have 
>a devfs or small devfs kernel, (so my init scripts can decide whether or 
>not to load devfsd?)

	I haven't tested this, but something like this might
work:

	if [ -e /dev/.devfsd ] ; then
		echo "Running old devfs"
		devfsd
	else
		echo "Running no devfs or new devfs."
	fi

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
