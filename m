Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTJWTZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 15:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTJWTZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 15:25:41 -0400
Received: from september.skynet.be ([195.238.3.57]:51875 "EHLO
	september.skynet.be") by vger.kernel.org with ESMTP id S261662AbTJWTZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 15:25:40 -0400
Message-Id: <200310231925.h9NJPZnU004358@september.skynet.be>
Date: Thu, 23 Oct 2003 21:25:35 +0200 (CEST)
From: Helmut Jarausch <jarausch@skynet.be>
Reply-To: Helmut Jarausch <jarausch@skynet.be>
Subject: 2.4.23-pre7 doesn't recognize 2nd processor with Intel E7505
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (september.skynet.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.23-pre7 doesn't recognize the second processor on a supermicro
board with Intel E7505 dual Xeon. (It runs fine on a dual P3 machine)

The 2.4.22-AC4 kernel recognizes both (even 4 of hyperthreading is
enabled)

Since we are still looking for a remedy to a kernel freeze (here on at
least two different SMP machines) when using a GL-application with and
WITHOUT the Nvidia video kernel module, we were hoping that the
recent fix for a race condition in mmap could help.

Any hints are appreciated,

Helmut Jarausch

Lehrstuhl fuer Numerische Mathematik
RWTH - Aachen University
D 52056 Aachen, Germany
