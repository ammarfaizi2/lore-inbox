Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937115AbWLDQgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937115AbWLDQgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937113AbWLDQgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:36:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56284 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937110AbWLDQgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:36:36 -0500
Subject: Re: [PATCH] move kallsyms data to .rodata
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45745A92.76E4.0078.0@novell.com>
References: <45745A92.76E4.0078.0@novell.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 04 Dec 2006 17:36:33 +0100
Message-Id: <1165250193.3233.297.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 16:27 +0000, Jan Beulich wrote:
> Kallsyms data is never written to, so it can as well benefit from
> CONFIG_DEBUG_RODATA.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>

Acked-by: Arjan van de Ven <arjan@linux.intel.com>


