Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267019AbSK2LdA>; Fri, 29 Nov 2002 06:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267020AbSK2LdA>; Fri, 29 Nov 2002 06:33:00 -0500
Received: from cibs9.sns.it ([192.167.206.29]:51473 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S267019AbSK2LdA>;
	Fri, 29 Nov 2002 06:33:00 -0500
Date: Fri, 29 Nov 2002 12:40:17 +0100 (CET)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: linux/security.h missing in fs/hugetlbfs/inode.c
Message-ID: <Pine.LNX.4.43.0211291238360.986-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#include <linux/security.h>

is missing in file fs/hugetlbfs/inode.c,
so security_ops is undeclared during compilation.



