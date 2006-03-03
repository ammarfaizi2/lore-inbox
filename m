Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752227AbWCCJiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbWCCJiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbWCCJiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:38:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14471 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752225AbWCCJiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:38:21 -0500
Subject: Re: [PATCH] adjust /dev/{kmem,mem,port} write handlers
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44081B03.76F0.0078.0@novell.com>
References: <44081B03.76F0.0078.0@novell.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 10:38:17 +0100
Message-Id: <1141378697.2883.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 10:31 +0100, Jan Beulich wrote:
> The /dev/mem and /dev/kmem write handlers weren't fully POSIX compliant in
> that they wouldn't always force the file pointer to be updated when returning
> success status.

should we instead just remove the /dev/mem and/or /dev/kmem write
handlers entirely?


