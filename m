Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267347AbSLKWgV>; Wed, 11 Dec 2002 17:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267349AbSLKWfz>; Wed, 11 Dec 2002 17:35:55 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26375 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267347AbSLKWfd>; Wed, 11 Dec 2002 17:35:33 -0500
Date: Wed, 11 Dec 2002 17:43:17 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200212112243.gBBMhH007535@devserv.devel.redhat.com>
To: "Felix Domke" <tmbinc@elitedvb.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Allocating 16MB aligned phsyical memory
In-Reply-To: <mailman.1039599127.17111.linux-kernel2news@redhat.com>
References: <mailman.1039599127.17111.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> At the moment, i'm reserving a 16MB space of ram for which i made an own
> allocater. needless to say that this sucks.

No, that's normal. Of course, you should have used Pauline's
bigphysarea patch, but otherwise it's a sane idea, IMHO.
 http://www.polyware.nl/~middelink/En/hob-v4l.html
 http://www.polyware.nl/~middelink/patch/bigphysarea-2.4.4.tar.gz

I often wonder why MPEG hardware designers are such dorks.
It is pretty common place between them to ask for contiguous
memory. I would say, 95% of requests for contiguous memory
comes from poor hacks who have to deal with DVRs, PVRs,
and such. Practically no other hardware is this idiotic.
Not that it's impossible to do right, or anything. I think,
stradis is sane.

-- Pete
