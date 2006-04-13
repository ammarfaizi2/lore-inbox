Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWDMTSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWDMTSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 15:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWDMTSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 15:18:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14796 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932456AbWDMTSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 15:18:13 -0400
Subject: Re: [PATCH 3/4] Remove unchecked flags
From: David Woodhouse <dwmw2@infradead.org>
To: Josh Boyer <jwboyer@gmail.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <625fc13d0604131108w68612124ga77fb5fd9f0a408c@mail.gmail.com>
References: <20060413165153.GD30574@wohnheim.fh-wedel.de>
	 <20060413165434.GG30574@wohnheim.fh-wedel.de>
	 <625fc13d0604131108w68612124ga77fb5fd9f0a408c@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 15:18:00 -0400
Message-Id: <1144955886.2697.78.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 13:08 -0500, Josh Boyer wrote:
> As a side note, these will also need to be removed from the mtd-utils
> tree.  The switch to git meant that mtd-utils has it's own copy of the
> sanitized headers.  The patch for mtd-abi.h should apply there as
> well. 

The idea is that include/mtd/ is sanitised for userspace, and those
headers should be identical. Having switched to git and separated the
userspace and kernel repositories, I hadn't yet worked out how to
address that.

-- 
dwmw2

