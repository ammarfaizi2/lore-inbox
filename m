Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbUJYIf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUJYIf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUJYIdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:33:43 -0400
Received: from canuck.infradead.org ([205.233.218.70]:36358 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261728AbUJYIcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:32:23 -0400
Subject: Re: Concerns about our pci_{save,restore}_state()
From: Arjan van de Ven <arjan@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <1098685464.26695.32.camel@gaston>
References: <1098677182.26697.21.camel@gaston>  <417C991C.2070806@pobox.com>
	 <1098685464.26695.32.camel@gaston>
Content-Type: text/plain
Message-Id: <1098693129.2798.9.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 25 Oct 2004 10:32:09 +0200
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

On Mon, 2004-10-25 at 16:24 +1000, Benjamin Herrenschmidt wrote:

> Currently, the default does nothing (doesn't even save/restore).

Are you sure? I could have sworn I made the default action to
save/restore some time ago

-- 

