Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVAFNGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVAFNGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVAFNGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:06:41 -0500
Received: from [213.146.154.40] ([213.146.154.40]:51877 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262816AbVAFNGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:06:38 -0500
Date: Thu, 6 Jan 2005 13:06:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050106130633.GA17229@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050106113216.GA16261@infradead.org> <20050103011113.6f6c8f44.akpm@osdl.org> <20050103100725.GA17856@infradead.org> <27229.1105016644@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27229.1105016644@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 01:04:04PM +0000, David Howells wrote:
> That's not right either. Filesystems really shouldn't be overloading the
> vm_ops on memory mappings (as has been made clear to me)

yes, they should.  And various filesystems do.

