Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWETC3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWETC3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 22:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWETC3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 22:29:51 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:48585 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S932415AbWETC3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 22:29:50 -0400
Subject: Re: [PATCH] fix broken vm86 interrupt/signal handling
From: Arjan van de Ven <arjan@infradead.org>
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Cc: linux-kernel@vger.kernel.org, roland@redhat.com, anemo@mba.ocn.ne.jp,
       mingo@elte.hu, Andrew Morton <akpm@osdl.org>
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C3EECE1B@scl-exch2k3.phoenix.com>
References: <0EF82802ABAA22479BC1CE8E2F60E8C3EECE1B@scl-exch2k3.phoenix.com>
Content-Type: text/plain
Date: Sat, 20 May 2006 04:29:47 +0200
Message-Id: <1148092188.3069.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 15:09 -0700, Aleksey Gorelov wrote:
> Hi,
> 
>   This patch
> www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h
> =c3ff8ec31c1249d268cd11390649768a12bec1b9 has broken vm86
> interrupt/signal handling in case when vm86 is called from kernel space.

can you point out where vm86 is called from kernel space?


