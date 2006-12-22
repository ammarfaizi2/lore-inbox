Return-Path: <linux-kernel-owner+w=401wt.eu-S1423000AbWLVOF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423000AbWLVOF7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423021AbWLVOF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:05:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50889 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423000AbWLVOF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:05:58 -0500
Date: Fri, 22 Dec 2006 14:05:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Rewrite unnecessary duplicated code to use FIELD_SIZEOF().
Message-ID: <20061222140550.GB26033@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612170738410.24046@localhost.localdomain> <20061220164651.4ee2e960.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220164651.4ee2e960.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 04:46:51PM -0800, Andrew Morton wrote:
> On Sun, 17 Dec 2006 07:43:39 -0500 (EST)
> "Robert P. J. Day" <rpjday@mindspring.com> wrote:
> 
> >   as with ARRAY_SIZE(), there are a number of places (mercifully, far
> > fewer) that recode what could be done with the FIELD_SIZEOF() macro in
> > kernel.h.

Who introduced FIELD_SIZEOF?  The name is the wrong way around, it should
either be SIZEOF_FIELD if you want the SIZEOF part of FIELD_SIZE if you
want to follow the ARRAY_SIZE example/

