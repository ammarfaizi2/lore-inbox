Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVBCB0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVBCB0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVBCBTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:19:42 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:49978 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262834AbVBCBOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:14:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uVfcz3pWhuYsWWDamMXMqZLR5X7CZnvo6ogzVJaPyN2qKfF+pQxZGGCBKtZaYqSuUzhOyJowrHz8zCqL+vNXoZpU2rCVL2U5kzsj37whWfJZfkDvMvcXJmh82Pgfh/AxdEroWYhhC8W4dcAmsIeOm17hVrp0dnWiTmGNyWXaWwk=
Message-ID: <58cb370e050202171465143ce7@mail.gmail.com>
Date: Thu, 3 Feb 2005 02:14:35 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 14/29] ide: remove NULL checking in ide_error()
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202025728.GO621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025728.GO621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:57:28 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 14_ide_error_remove_NULL_test.patch
> >
> >       In ide_error(), drive cannot be NULL.  ide_dump_status() can't
> >       handle NULL drive.

applied, you missed Signed-off-by line
