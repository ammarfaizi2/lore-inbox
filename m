Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268292AbUIFRCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268292AbUIFRCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 13:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268310AbUIFRCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 13:02:19 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:6919 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268292AbUIFRCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 13:02:19 -0400
Date: Mon, 6 Sep 2004 18:02:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make key management use syscalls not prctls
Message-ID: <20040906180212.A7860@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <12228.1094472878@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <12228.1094472878@redhat.com>; from dhowells@redhat.com on Mon, Sep 06, 2004 at 01:14:38PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umm, sys_keyctl is one of those ioctl lookalikes that are an incredible
pain for 32bit compat and we agreed to not add anymore.

