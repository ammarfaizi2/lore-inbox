Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVA0UXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVA0UXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVA0UXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:23:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22992 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261160AbVA0UXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:23:36 -0500
Date: Thu, 27 Jan 2005 20:23:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
Message-ID: <20050127202335.GA2033@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127101322.GE9760@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +		p = arch_align_stack((unsigned long)p);

looking at the code p already is unsigned long, so the cast is not needed.

