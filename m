Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVDEKO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVDEKO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDEKLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:11:09 -0400
Received: from main.gmane.org ([80.91.229.2]:27799 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261687AbVDEKJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 06:09:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: 2.6.12-rc2-mm1
Date: Tue, 05 Apr 2005 12:08:56 +0200
Message-ID: <d2to03$t0t$1@sea.gmane.org>
References: <20050405000524.592fc125.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 195.70.138.133.adsl.nextra.cz
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

[...]

Does not compile on AthlonXP. For mmx_clear_page, only the prototype was
changed, but the implementation is still the same. I guess that part of
the patch slipped out somehow.

-extern void mmx_clear_page(void *page);

+extern void mmx_clear_page(void *page, int order);

-- 
Jindrich Makovicka

