Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSKZLrb>; Tue, 26 Nov 2002 06:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264643AbSKZLrb>; Tue, 26 Nov 2002 06:47:31 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62414 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261545AbSKZLra>; Tue, 26 Nov 2002 06:47:30 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211261154.gAQBsdL03336@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.49-ac1
To: szepe@pinerecords.com (Tomas Szepe)
Date: Tue, 26 Nov 2002 06:54:39 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20021126035518.GC29196@louise.pinerecords.com> from "Tomas Szepe" at Nov 26, 2002 04:55:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> include/asm/io_apic.h: In function `io_apic_modify':
> include/asm/io_apic.h:128: =01pic_sis_bug' undeclared (first use in this fu=

Your tree is corrupt, looks like flipped bits (its gone from 'a' to ^A)
