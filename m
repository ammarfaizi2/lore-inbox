Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbULCMPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbULCMPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 07:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbULCMPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 07:15:36 -0500
Received: from picard.ine.co.th ([203.152.41.3]:42425 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S262179AbULCMP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 07:15:27 -0500
Subject: Re: 2.6.9, 64bit, 4GB memory => panics ...
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041203113704.GD2714@holomorphy.com>
References: <1102072834.31282.1450.camel@cpu0>
	 <20041203113704.GD2714@holomorphy.com>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Message-Id: <1102076115.31282.1456.camel@cpu0>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Dec 2004 19:15:15 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-03 at 18:37, William Lee Irwin III wrote:
> The full panic message would help a lot. We can't do much without it.
> 
> -- wli

I was hoping to be able to get the entire panic screen, but
am only getting the bottom of it ...

Does this help ?


FS: 0000002a95cea6e0(0000) GS: ffffffff80516b00(0000) knlGS: 0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000002 CR3: 0000000000011000 CR4: 00000000000006ed
Process as (pid: 4312, threadinfo 00000101735e0000, task 00000101746c9070)
Stack: ffffffff80141160 0000000000000012 0000010176b87fa0 0000000000000000
       000001000709a200 0000010175b37730 000001017aed32c0 000000000000005d
       ffffffff801c6f1d 000001016bfd1310
Call Trace: <ffffffff80141160>{__mod_timer+160}    <ffffffff801c6f1d>{start_this_handle+605}
            <ffffffff80159bcd>{filemap_nopage+413} <ffffffff8019335c>{__d_lookup+300}
            <ffffffff80187c47>{do_lookup+55}       <ffffffff801c724f>{journal_start+239}
            <ffffffff801c20bd>{ext3_create+45}     <ffffffff8018957d>{vfs_create+237}
            <ffffffff80189a00>{open_namei+432}     <ffffffff801796a7>{filp_open+39}
            <ffffffff801797be>{get_unused_fd+238}  <ffffffff8017990c>{sys_open+76}
            <ffffffff801105f6>{system_call+126}

Code: f0 fe 0f 0f 88 8e 02 00 00 c3 66 66 90 66 66 90 c6 07 01 c3
RIP <ffffffff8038443e0>{spin_lock+0} RSP <00000101735e1cc0>
CR2: 0000000000000002



Kind Regards,
rudi

