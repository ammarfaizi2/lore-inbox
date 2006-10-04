Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWJDNbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWJDNbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWJDNbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:31:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49031 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932424AbWJDNbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:31:41 -0400
Subject: Re: [PATCH] fs/jffs2: kill warning RE debug-only variables
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061004115718.GA22386@havoc.gtf.org>
References: <20061004115718.GA22386@havoc.gtf.org>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Oct 2006 14:31:28 +0100
Message-Id: <1159968688.20586.18.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 07:57 -0400, Jeff Garzik wrote:
> build:
> 
> fs/jffs2/xattr.c: In function ‘unrefer_xattr_datum’:
> fs/jffs2/xattr.c:402: warning: unused variable ‘version’
> fs/jffs2/xattr.c:402: warning: unused variable ‘xid’
> 
> Given that these variables are only used in the debug printk, and they
> merely remove a deref, we can easily kill the warning by adding the
> derefs to the debug printk.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>

Applied; thanks.

-- 
dwmw2

