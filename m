Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWAKSVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWAKSVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWAKSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:21:51 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:15816 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932445AbWAKSVu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:21:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hFXJRlIuY1sim+cpc6HYxZuPVxyXu6sfWZh2PAAx0z4u2Q2zLt+BYH8tihnTmzgZM1Z1LjhFDwFPJSGwiqsa/XkS5g7AZOy1bLgdg1KumzrP8NxuEW1DIaDHdU8O7V49JgRglAde0zJrQ/BdkUlPop5Bz++zBMX/LeX7bwwYsuo=
Message-ID: <86802c440601111021m7cb40881m7206d9342534f844@mail.gmail.com>
Date: Wed, 11 Jan 2006 10:21:47 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: can not compile in the latest git
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the functions are in
#if CONFIG_MIGRATION
...

mm/built-in.o(.text+0x16fc3): In function `check_pte_range':
mempolicy.c: undefined reference to `isolate_lru_page'
mm/built-in.o(.text+0x189a6): In function `swap_pages':
mempolicy.c: undefined reference to `migrate_pages'
mm/built-in.o(.text+0x189b3):mempolicy.c: undefined reference to
`putback_lru_pages'
mm/built-in.o(.text+0x189bd):mempolicy.c: undefined reference to
`putback_lru_pages'
mm/built-in.o(.text+0x18c98): In function `do_mbind':
: undefined reference to `putback_lru_pages'
mm/built-in.o(.text+0x18efe): In function `do_migrate_pages':
: undefined reference to `putback_lru_pages'
make: *** [.tmp_vmlinux1] Error 1


YH
