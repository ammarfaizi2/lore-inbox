Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVDEHpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVDEHpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVDEHpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:45:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33500 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261602AbVDEHi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:38:56 -0400
Date: Tue, 5 Apr 2005 08:38:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] biarch compiler support for i386
Message-ID: <20050405073828.GD26208@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <42522CB8.1010007@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42522CB8.1010007@zytor.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 11:14:16PM -0700, H. Peter Anvin wrote:
> This allows the i386 architecture to be built on a system with a biarch 
> compiler that defaults to x86-64, merely by specifying ARCH=i386.
> 
> As previously discussed, this uses the equivalent logic to the ppc port.

Given that the same logic applies to various other ports maybe it should
go into a common Makefile fragment?

