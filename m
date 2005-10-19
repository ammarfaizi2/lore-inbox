Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbVJSWQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbVJSWQT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 18:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbVJSWQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 18:16:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:46281 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751590AbVJSWQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 18:16:19 -0400
Subject: MADV_FREE ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 15:15:39 -0700
Message-Id: <1129760139.8716.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering if someone knew what MADV_FREE is supposed
or intended to do ? I see it sparc* headers. I don't see any
code to implement it or for any other architecture.

./include/asm-sparc64/mman.h:#define MADV_FREE  0x5             
	/* (Solaris) contents can be freed  */
./include/asm-sparc/mman.h:#define MADV_FREE    0x5             
	/* (Solaris) contents can be freed  */

Is this carry over from old days ?

Thanks,
Badari

