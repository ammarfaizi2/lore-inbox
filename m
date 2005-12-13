Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVLMJEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVLMJEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVLMJEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:04:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53896 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964801AbVLMJEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:04:36 -0500
Date: Tue, 13 Dec 2005 09:04:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, dhowells@redhat.com,
       torvalds@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213090429.GC27857@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org,
	arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213084926.GN23384@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Remove -Wdeclaration-after-statement
> 
> Now that gcc 2.95 is not supported anymore it's ok to use C99
> style mixed declarations everywhere.

Nack.  This code style is pure obsfucation and we should disallow it forever.

