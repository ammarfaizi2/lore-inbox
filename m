Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270627AbTHORda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270632AbTHORda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:33:30 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:15609 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S270627AbTHORdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:33:25 -0400
Date: Fri, 15 Aug 2003 18:32:47 +0100
From: Dave Jones <davej@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Debug: sleeping function called from invalid context
Message-ID: <20030815173246.GB9681@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815101856.3eb1e15a.rddunlap@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 10:18:56AM -0700, Randy.Dunlap wrote:

 > Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
 > Call Trace:
 >  [<c0120d94>] __might_sleep+0x54/0x5b
 >  [<c010d001>] save_v86_state+0x71/0x1f0
 >  [<c010dbd5>] handle_vm86_fault+0xc5/0xa90
 >  [<c019cab8>] ext3_file_write+0x28/0xc0
 >  [<c011cd96>] __change_page_attr+0x26/0x220
 >  [<c010b310>] do_general_protection+0x0/0x90
 >  [<c010a69d>] error_code+0x2d/0x40
 >  [<c0109657>] syscall_call+0x7/0xb

That's one really wierd looking backtrace. What else was that
machine up to at the time ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
