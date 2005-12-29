Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbVL2LtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVL2LtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVL2LtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:49:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59103 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932557AbVL2LtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:49:10 -0500
Subject: Re: Redefinition error while compiling LKM
From: Arjan van de Ven <arjan@infradead.org>
To: "pretorious ." <pretorious_i@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY23-F27F5FACE353137AF8C88F8F7290@phx.gbl>
References: <BAY23-F27F5FACE353137AF8C88F8F7290@phx.gbl>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 12:49:07 +0100
Message-Id: <1135856947.2935.17.camel@laptopd505.fenrus.org>
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

On Thu, 2005-12-29 at 16:51 +0530, pretorious . wrote:
> >
> >and.. why on earth would you need sys/syscall.h ?? (or sys/stat.h for
> >that matter)
> >
> >
> 
> Trying to override certain syscalls (mknod ...)

eeppp why??
really don't do that!

(overriding syscalls from modules really shouldn't be done.. there's a
reason the syscall table isn't exported!)

