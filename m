Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272226AbTHRSOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272229AbTHRSOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:14:42 -0400
Received: from [63.247.75.124] ([63.247.75.124]:21653 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S272226AbTHRSOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:14:41 -0400
Date: Mon, 18 Aug 2003 14:14:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@infradead.org>, Andries.Brouwer@cwi.nl,
       Dominik.Strasser@t-online.de, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030818181440.GK24693@gtf.org>
References: <UTC200308181219.h7ICJfw14963.aeb@smtp.cwi.nl> <20030818132451.A22393@infradead.org> <20030818180845.GB3889@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818180845.GB3889@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 08:08:46PM +0200, Sam Ravnborg wrote:
> hpa IIRC suggested to create a separate directory:
> include/abi
> and then all relevant parts of the kernel should publish their public
> interface in the abi directory. Would that be usefull?

I support include/abi, or some other directory that segregates
user<->kernel shared headers away from kernel-private headers.

I don't see how that would be auto-generated, though.  Only created
through lots of hard work :)

	Jeff



