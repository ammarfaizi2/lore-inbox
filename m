Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRCWLhL>; Fri, 23 Mar 2001 06:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130619AbRCWLhB>; Fri, 23 Mar 2001 06:37:01 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:53924 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130552AbRCWLgq>; Fri, 23 Mar 2001 06:36:46 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 23 Mar 2001 03:35:56 -0800
Message-Id: <200103231135.DAA08060@baldur.yggdrasil.com>
To: marcelo@conectiva.com.br
Subject: Re: Patch(?): linux-2.4.3-pre6/mm/vmalloc.c could return with init_mm.page_table_lock held
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:
>There is no need to hold mm->page_table_lock for vmalloced memory.

	I don't know if it makes a difference, but I should clarify
that mm == &init_mm throughout this code, not &current->mm.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
