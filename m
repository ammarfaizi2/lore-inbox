Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbUATLOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbUATLOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:14:42 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:63748 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265289AbUATLOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:14:42 -0500
Date: Tue, 20 Jan 2004 11:14:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm5
Message-ID: <20040120111441.A14570@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20040120000535.7fb8e683.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040120000535.7fb8e683.akpm@osdl.org>; from akpm@osdl.org on Tue, Jan 20, 2004 at 12:05:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any reason you keep CardServices-compatibility-layer.patch around?
Having a compat layer for old driver around just for some architectures,
thus having drivers that only compile on some for no deeper reasons sounds
like an incredibly bad idea.  Especially when that API is not used by any
intree driver and only in -mm ;)
