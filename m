Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263480AbSJGVym>; Mon, 7 Oct 2002 17:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263482AbSJGVym>; Mon, 7 Oct 2002 17:54:42 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:24725
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S263480AbSJGVym>; Mon, 7 Oct 2002 17:54:42 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200210072200.g97M0K930779@www.hockin.org>
Subject: unused code?  include/linux/nfsiod.h
To: linux-kernel@vger.kernel.org
Date: Mon, 7 Oct 2002 15:00:20 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/nfsiod.h

It seems like nothing is using this header file.  It is all protected by
ifdef __KERNEL__, so it seems unlikely that anything in userland uses it.
Is there some out-of-tree kernel project using it?

Tim
