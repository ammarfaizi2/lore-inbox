Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbULPRmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbULPRmD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbULPRmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:42:03 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33764 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261436AbULPRl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:41:56 -0500
Subject: Re: 2.6.10-rc3-mm1
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041213020319.661b1ad9.akpm@osdl.org>
References: <20041213020319.661b1ad9.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 16 Dec 2004 11:49:46 -0600
Message-Id: <1103219387.32505.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> remove-unnecessary-inclusions-of-asm-aouth.patch
>   Remove unnecessary inclusions of asm/a.out.h

Breaks alpha defconfig build here:

  CC      fs/exec.o
fs/exec.c: In function `search_binary_handler':
fs/exec.c:1007: error: dereferencing pointer to incomplete type
fs/exec.c:1008: error: dereferencing pointer to incomplete type
fs/exec.c:1025: error: dereferencing pointer to incomplete type


Nathan

