Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVAELa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVAELa3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVAELa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:30:29 -0500
Received: from [213.146.154.40] ([213.146.154.40]:59024 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262333AbVAELaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:30:18 -0500
Date: Wed, 5 Jan 2005 11:30:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Felipe Alfaro Solana <lkml@mac.com>, Rik van Riel <riel@redhat.com>,
       Adrian Bunk <bunk@stusta.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       William Lee Irwin III <wli@debian.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Subject: Re: starting with 2.7
Message-ID: <20050105113008.GA31195@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Willy Tarreau <willy@w.ods.org>,
	Felipe Alfaro Solana <lkml@mac.com>, Rik van Riel <riel@redhat.com>,
	Adrian Bunk <bunk@stusta.de>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	William Lee Irwin III <wli@holomorphy.com>,
	William Lee Irwin III <wli@debian.org>,
	linux-kernel@vger.kernel.org, Andries Brouwer <aebr@win.tue.nl>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Maciej Soltysiak <solt2@dns.toxicfilms.tv>
References: <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com> <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com> <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com> <20050103221441.GA26732@infradead.org> <20050104054649.GC7048@alpha.home.local> <20050104063622.GB26051@parcelfarce.linux.theplanet.co.uk> <9F909072-5E3A-11D9-A816-000D9352858E@mac.com> <Pine.LNX.4.61.0501040735410.25392@chimarrao.boston.redhat.com> <85546E06-5E50-11D9-A816-000D9352858E@mac.com> <20050104200912.GA22075@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104200912.GA22075@alpha.home.local>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 09:09:12PM +0100, Willy Tarreau wrote:
> Not only proprietary software. I nearly don't use any (vmware a few times a
> year). Viro would tell you that the problem is on the editor's side. I have
> often been annoyed by opensource patches breakage. Try to use the same PaX
> patch for 4 months, for example, without getting rejects nor wrongly applied
> chunks !

Note that even if we had a stable _driver_ interface PaX would certainly
not fall under that.  It pokes really deep into VM interals.

