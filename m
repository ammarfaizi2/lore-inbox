Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVC3Oi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVC3Oi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVC3Oi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:38:59 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:44048 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261915AbVC3Oi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:38:56 -0500
To: =?iso-8859-1?q?Xu=E2n_Baldauf?= 
	<xuan--2004.03.29--linux-kernel--vger.kernel.org@baldauf.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vfat: why is shortname=lower the default?
References: <4249BB5C.5000102@baldauf.org>
	<871x9xs2fy.fsf@devron.myhome.or.jp> <424AA8E8.1020008@baldauf.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 30 Mar 2005 23:38:44 +0900
In-Reply-To: <424AA8E8.1020008@baldauf.org> (
 =?iso-8859-1?q?Xu=E2n_Baldauf's_message_of?= "Wed, 30 Mar 2005 15:26:00
 +0200")
Message-ID: <87mzslqjuz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xuân Baldauf <xuan--2004.03.29--linux-kernel--vger.kernel.org@baldauf.org> writes:

> One could make a slow transition, starting now with a warning like
> "vfat: warning: You are using "shortname=lower" as default. This may
> not be what you want. This default will change to "shortname=mixed"
> after 2005-07-01." if the shortname behaviour is not explicitly
> selected.

Yes. But it is easy ignored. So, maybe peoples doesn't complain until
it is changed in fact.

Probably you can post the patch for -mm tree.

And it is tested in -mm tree. And at starting of dev-cycle of 2.6.13
or 2.6.14, it will be merged to Linus's tree if anyone has no objection.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
