Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269832AbUJGVah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269832AbUJGVah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268440AbUJGV2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:28:53 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:41993 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269715AbUJGV1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:27:39 -0400
Date: Thu, 7 Oct 2004 22:27:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] use offsetof for rb_entry
Message-ID: <20041007222733.A18083@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	blaisorblade_spam@yahoo.it, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20041007175343.AE28944CD@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041007175343.AE28944CD@zion.localdomain>; from blaisorblade_spam@yahoo.it on Thu, Oct 07, 2004 at 07:53:42PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 07:53:42PM +0200, blaisorblade_spam@yahoo.it wrote:
> 
> Use, in the rb_entry definition, the offsetof macro instead of reinventing the
> wheel.

Or just use container_of - which has the additional benefit of beeing typesafe.

