Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265923AbUF2SrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbUF2SrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265903AbUF2SrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:47:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26871 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265923AbUF2SrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:47:24 -0400
Subject: per-process namespace?
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: viro@parcelfarce.linux.theplanet.co.uk
Content-Type: text/plain
Organization: 
Message-Id: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2004 11:47:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way for an application to
1. fork its own namespace and modify it, and
2. still be able to see changes to the system namespace?

Al Viro's Per-process namespace implementation provides the first
feature.  But is there any work done to do the second part? Is it worth
doing?

RP


