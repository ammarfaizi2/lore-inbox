Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282025AbRKWGcZ>; Fri, 23 Nov 2001 01:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282056AbRKWGcR>; Fri, 23 Nov 2001 01:32:17 -0500
Received: from zok.sgi.com ([204.94.215.101]:3032 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S282025AbRKWGb5>;
	Fri, 23 Nov 2001 01:31:57 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: Thomas Davis <tadavis@lbl.gov>
Subject: 2.4.15-final drivers/net/bonding.c includes user space headers
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Nov 2001 17:31:43 +1100
Message-ID: <18133.1006497103@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.15-final/drivers/net/bonding.c:188: #include <limits.h>

Kernel code must not include use space headers.  I thought this had
been fixed.  It will not compile in 2.5.

