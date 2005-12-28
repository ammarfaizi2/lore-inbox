Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVL1IdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVL1IdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 03:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVL1IdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 03:33:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22925 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932515AbVL1IdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 03:33:17 -0500
Subject: Re: [vma list corruption] Re: proc_pid_readlink oopses again on
	2.6.14.5
From: Arjan van de Ven <arjan@infradead.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051228065354.GE27946@ftp.linux.org.uk>
References: <dot96e$e76$1@sea.gmane.org>
	 <20051228065354.GE27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 09:33:13 +0100
Message-Id: <1135758794.2935.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So you've got 0xb7c1fc20 as vma.  Which is not good, since that's a userland
> address.

sounds like it may also be a good idea to check for rootkits; some of
those try to muck with the vma chains and stuff.... and break if the
kernel changes a bit.

