Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVH3XKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVH3XKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVH3XKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:10:39 -0400
Received: from smtp.istop.com ([66.11.167.126]:18630 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932283AbVH3XKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:10:39 -0400
From: Daniel Phillips <phillips@istop.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 3 of 4] Configfs is really sysfs
Date: Wed, 31 Aug 2005 09:10:35 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>
References: <200508310854.40482.phillips@istop.com> <200508310857.57617.phillips@istop.com> <200508310859.55746.phillips@istop.com>
In-Reply-To: <200508310859.55746.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508310910.35719.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 08:59, Daniel Phillips wrote:
> -obj-$(CONFIG_CONFIGFS_FS) += configfs.o
> +obj-$(CONFIG_CONFIGFS_FS) += configfs.o ddbond.config.o

This should just be:

+obj-$(CONFIG_CONFIGFS_FS) += configfs.o

However, the wrong version does provide a convenient way of compiling the
example, I just... have... to... remember to delete it next time.

Regards,

Daniel
