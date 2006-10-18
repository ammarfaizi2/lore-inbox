Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWJRK1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWJRK1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWJRK1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:27:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51122 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751455AbWJRK1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:27:24 -0400
Date: Wed, 18 Oct 2006 11:27:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: public SGI_IOC4
Message-ID: <20061018102719.GC1767@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Olaf Hering <olaf@aepfle.de>, Brent Casavant <bcasavan@sgi.com>,
	linux-kernel@vger.kernel.org
References: <20061018075432.GA13312@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018075432.GA13312@aepfle.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 09:54:32AM +0200, Olaf Hering wrote:
> 
> Commit 59f148005cfd3d41537a4b872c266213d5fe4dc6 adds a public
> CONFIG_SGI_IOC4. Can you make that one ia64 only?

It's intentional.  The patches mentioned sgi now has a bog standard
pci card with that chip on it, and will ship it in their x86 machines.

(which is rather unfortunate, ioc4 is a really messy piece of hardware -
 no idea why they want to infect the rest of the world with that pest.. :))
