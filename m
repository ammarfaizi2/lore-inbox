Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSHVSnl>; Thu, 22 Aug 2002 14:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSHVSnl>; Thu, 22 Aug 2002 14:43:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:4293 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315445AbSHVSnk>;
	Thu, 22 Aug 2002 14:43:40 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 22 Aug 2002 20:47:49 +0200 (MEST)
Message-Id: <UTC200208221847.g7MIlnq24081.aeb@smtp.cwi.nl>
To: Matt_Domsch@Dell.com
Subject: NULL_GUID
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier this evening I happened to compile a 2.4.20-pre4 and got

efi.c: In function `add_gpt_partitions':
efi.c:728: `NULL_GUID' undeclared (first use in this function)

Earlier it was defined in include/asm-ia64/efi.h,
but since there is no relation with ia64 it is reasonable
that it was moved, only it never arrived in partitions/efi.h.

[I'll be lazy and not supply the trivial patch. Too likely
that others already did.]

Andries
