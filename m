Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUIFRDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUIFRDb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 13:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUIFRDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 13:03:31 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:7687 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268310AbUIFRDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 13:03:22 -0400
Date: Mon, 6 Sep 2004 18:03:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc1-mm3] [m32r] Modify sys_ipc() to remove useless iBCS2 support code
Message-ID: <20040906180315.B7860@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hirokazu Takata <takata@linux-m32r.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903105423.A3179@infradead.org> <20040906.214051.336469534.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040906.214051.336469534.takata.hirokazu@renesas.com>; from takata@linux-m32r.org on Mon, Sep 06, 2004 at 09:40:51PM +0900
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The useless iBCS2 supporting code is removed.
> 
> However, according to old_ syscalls, I would like to keep backward-
> compatibility for a while, due to some old deb packages and 
> executables for m32r.  
> I'm struggling to rebuild and replace old packages to new ones.
> http://debian.linux-m32r.org/

Please keep support for those as a separate patch, or at least as a 
COFIG_ option that's marked deprecated (with a date that it's scheduled
to be removed for)

