Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSLLTTB>; Thu, 12 Dec 2002 14:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSLLTTB>; Thu, 12 Dec 2002 14:19:01 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:40812 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264630AbSLLTTB>; Thu, 12 Dec 2002 14:19:01 -0500
Date: Thu, 12 Dec 2002 14:26:45 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (8/8): export sys_wait4.
Message-ID: <20021212142645.A2998@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +EXPORT_SYMBOL(sys_wait4);

Martin, hold on just a second. Last I checked, sys_wait4 was
used ONLY by a moronic code in ipvs, _and_ there was a comment
by the author above it "we are too lazy to do it properly".
Do you have a better reason to export it?

-- Pete
