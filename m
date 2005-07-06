Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVGFLp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVGFLp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 07:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVGFLd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 07:33:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9119 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262161AbVGFJAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 05:00:15 -0400
Date: Wed, 6 Jul 2005 10:00:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Donald.Huang@ite.com.tw
Subject: Re: [PATCH -mm] iteraid: remove ITE_IOC_GET_DRIVER_VERSION
Message-ID: <20050706090011.GC21650@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Donald.Huang@ite.com.tw
References: <200507052324.24654.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507052324.24654.adobriyan@gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can just kill the driver again, mainline now has the proper ide-layer
driver for the hardware.  The scsi-layer driver is not going in with any
amount of cleanups, it's just conceptually wrong.

