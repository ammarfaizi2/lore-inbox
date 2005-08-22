Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVHVVlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVHVVlY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVHVVlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:41:23 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64385 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751259AbVHVVlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:41:23 -0400
Date: Mon, 22 Aug 2005 15:07:46 +0200
From: Andi Kleen <ak@suse.de>
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Cc: lkml.hyoshiok@gmail.com, ak@suse.de, arjan@infradead.org,
       taka@valinux.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Message-ID: <20050822130746.GB19007@wotan.suse.de>
References: <98df96d305081804061ea70686@mail.gmail.com> <20050818.201138.607962419.hyoshiok@miraclelinux.com> <98df96d30508181629d85edb5@mail.gmail.com> <20050822.102457.576033486.hyoshiok@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822.102457.576033486.hyoshiok@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) low latency version of cache aware copy

Having a low latency version that is only active with CONFIG_PREEMPT 
is bad - non preempt kernels need good latency too.

-Andi
