Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265574AbUFIKdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbUFIKdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 06:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUFIKdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 06:33:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43424 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265574AbUFIKdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 06:33:12 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Fix PCI hotplug of promise IDE cards
Date: Wed, 9 Jun 2004 12:37:01 +0200
User-Agent: KMail/1.5.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040607225115.GC7412@krispykreme>
In-Reply-To: <20040607225115.GC7412@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406091237.01429.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 of June 2004 00:51, Anton Blanchard wrote:
> Hi,

Hi,

> It looks like no one has tried hotplugging Promise IDE cards :)

Yep and this bug is present in some other drivers.
Debian kernel patchkit has fixes for them but it goes too far
and fixes drivers for hardware which is not hot-pluggable.

> Anton
>
> --
>
> Change some __init functions in the pdc202xx driver to be __devinit, they
> are used when hotpluging.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>

