Return-Path: <linux-kernel-owner+w=401wt.eu-S932099AbXAIOG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbXAIOG7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbXAIOG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:06:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59845 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbXAIOG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:06:58 -0500
Subject: Re: [PATCH] agpgart: Allow drm-populated agp memory types
From: Arjan van de Ven <arjan@infradead.org>
To: thomas@tungstengraphics.com
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, arlied@gmail.com
In-Reply-To: <11683309992144-git-send-email-thomas@tungstengraphics.com>
References: <11682488182899-git-send-email-thomas@tungstengraphics.com>
	 <11683309992144-git-send-email-thomas@tungstengraphics.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 09 Jan 2007 06:06:58 -0800
Message-Id: <1168351618.3180.274.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +	agp_vkmalloc(alloc_size, &new->memory, &new->vmalloc_flag);


ok why wouldn't agp_vkmalloc take a size and just only "new" as argument
here? Just pass it a pointer to the struct it fills in anyway...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

