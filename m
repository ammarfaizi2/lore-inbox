Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264537AbSIWFCR>; Mon, 23 Sep 2002 01:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264546AbSIWFCQ>; Mon, 23 Sep 2002 01:02:16 -0400
Received: from holomorphy.com ([66.224.33.161]:10644 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264537AbSIWFCQ>;
	Mon, 23 Sep 2002 01:02:16 -0400
Date: Sun, 22 Sep 2002 21:59:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.38-mm1 dbench 512 might sleep backtrace emitted
Message-ID: <20020923045914.GI25605@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trace; c01175f7 <__might_sleep+27/2b>
Trace; c0139764 <__alloc_pages+24/24c>
Trace; f8e74698 <END_OF_CODE+38ac8334/????>
Trace; c011300d <pte_alloc_one+41/118>
Trace; c012b89d <pte_alloc_map+4d/214>
Trace; c012da28 <vmtruncate+138/164>
Trace; c0133f68 <move_one_page+e8/328>
Trace; c0134091 <move_one_page+211/328>
Trace; c01341d9 <move_page_tables+31/7c>
Trace; c0134870 <do_mremap+64c/7cc>
Trace; c0134a40 <sys_mremap+50/73>
Trace; c010746f <syscall_call+7/b>

