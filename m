Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSKNX7c>; Thu, 14 Nov 2002 18:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSKNX7c>; Thu, 14 Nov 2002 18:59:32 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15771 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265368AbSKNX7b>; Thu, 14 Nov 2002 18:59:31 -0500
Date: Thu, 14 Nov 2002 19:06:19 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200211150006.gAF06JF01621@devserv.devel.redhat.com>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
In-Reply-To: <mailman.1037316781.6599.linux-kernel2news@redhat.com>
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two questions.

1. Why are arrays vmalloc-ed? This is a goochism which you have
   to justify.

2. How do these changes sit with LLNL's changes to increase
   number of groups that NFS client can support? It's not
   a showstopper, but would be nice if you two cooperated.

-- Pete
