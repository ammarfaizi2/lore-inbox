Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVHLWLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVHLWLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 18:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVHLWLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 18:11:04 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:48527 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1751300AbVHLWLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 18:11:02 -0400
Date: Sat, 13 Aug 2005 00:13:52 +0200
From: DervishD <lkml@dervishd.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: 7eggert@gmx.de, harvested.in.lkml@7eggert.dyndns.org,
       vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: Re: Problem with usb-storage and /dev/sd?
Message-ID: <20050812221352.GA265@DervishD>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>, 7eggert@gmx.de,
	harvested.in.lkml@7eggert.dyndns.org, vonbrand@inf.utfsm.cl,
	linux-kernel@vger.kernel.org
References: <4pzyn-10f-33@gated-at.bofh.it> <4AubX-4w6-9@gated-at.bofh.it> <E1E3X6P-0000cN-BB@be1.lrz> <20050812103832.28ff17a0.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050812103832.28ff17a0.zaitcev@redhat.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Pete :)

 * Pete Zaitcev <zaitcev@redhat.com> dixit:
> > Which label will a random USB stick have?
> GUID, I presume. Ask Andries Brouwer, he hacked on that, IIRC.
> Actually msdos has on-disk format for user-settable labels in
> the way analoguous to tune2fs -L label. I just do not know if
> our implementation recognizes them.

    My vfat's in my MP3 player and the USB stick doesn't have a
label, at least not one usable by 'mount' (which only uses ext2/3
labels and xfs labels AFAIK).

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
