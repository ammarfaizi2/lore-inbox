Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUFXNrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUFXNrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUFXNrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:47:04 -0400
Received: from mail2-116.ewetel.de ([212.6.122.116]:18330 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S264777AbUFXNrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:47:02 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using gcc built-ins for bitops?
In-Reply-To: <2awGH-DF-17@gated-at.bofh.it>
References: <2awGH-DF-17@gated-at.bofh.it>
Date: Thu, 24 Jun 2004 15:46:50 +0200
Message-Id: <E1BdUZ0-00004M-QC@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004 09:20:07 +0200, you wrote in linux.kernel:

> +#if __GNUC_MINOR__ >= 4
> +#define HAVE_BUILTIN_CTZL
> +#endif

Eh, what value does __GNUC_MINOR__ have for, say, gcc-2.95.x?

-- 
Ciao,
Pascal
