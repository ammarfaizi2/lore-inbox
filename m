Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbUKHMFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUKHMFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 07:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUKHMFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 07:05:10 -0500
Received: from canuck.infradead.org ([205.233.218.70]:51468 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261812AbUKHMFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 07:05:06 -0500
Subject: Re: VMM:  syscall for reordering pages in vm
From: Arjan van de Ven <arjan@infradead.org>
To: Willibald Krenn <Willibald.Krenn@gmx.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <418F4F97.5000805@gmx.at>
References: <418F4F97.5000805@gmx.at>
Content-Type: text/plain
Message-Id: <1099915498.3577.7.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 08 Nov 2004 13:04:58 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 11:51 +0100, Willibald Krenn wrote:
> Quick Summary:
> 
> (Good or Bad?) Idea of implementing a syscall that allows
> for virtual memory page exchange by modifying the physical<->virtual
> page mapping. Intended usage: Moving pages in virtual memory without
> the need to copy them. Feedback welcome!

eh isn't this already possible with mmap and mremap ?

