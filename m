Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbULHMmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbULHMmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 07:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbULHMmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 07:42:20 -0500
Received: from canuck.infradead.org ([205.233.218.70]:36872 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261197AbULHMmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 07:42:18 -0500
Subject: Re: [3/6] Xen VMM #4: runtime disable of VT console
From: David Woodhouse <dwmw2@infradead.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org
In-Reply-To: <E1CbwGw-0006Rk-00@mta1.cl.cam.ac.uk>
References: <E1CbwGw-0006Rk-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 12:41:32 +0000
Message-Id: <1102509692.5122.201.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 07:30 +0000, Ian Pratt wrote:
> This patch enables the VT console to be disabled at runtime even if it
> is built into the kernel. Arch xen needs this to avoid trying to
> initialise a VT in virtual machine that doesn't have access to the
> console hardware.

Embedded machines often don't have console hardware either. Why is this
different? Should console_use_vt default to zero and be set only when we
find vt-capable hardware?

-- 
dwmw2

