Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSFZA0c>; Tue, 25 Jun 2002 20:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSFZA0b>; Tue, 25 Jun 2002 20:26:31 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:10722 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S316185AbSFZA0a>; Tue, 25 Jun 2002 20:26:30 -0400
Date: Tue, 25 Jun 2002 18:57:46 -0400
From: Doug Ledford <dledford@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@redhat.com, linux-scsi@redhat.com
Subject: [PATCH] initio driver update
Message-ID: <20020625185746.A19388@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The initio a100 driver has not worked for some time now (needed updating 
to the DMA mapping API).  This patch implements an update to the DMA 
mapping API plus fixes a lot of obvious problems I saw in the driver (I'm 
sure more exist).  I don't have hardware to test this, so testers would 
be *much* appreciated.  It compiles, that's all I guarantee until testers 
step forward.  However, it can't be any worse than the old version since 
the old version wouldn't compile.  Linus, please apply this (and let me 
know if you don't like pulling patches this way, it was too big to send 
to the mailing lists).  Thanks.

http://people.redhat.com/dledford/patches/initio.patch

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
