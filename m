Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752427AbWCPRJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbWCPRJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbWCPRJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:09:51 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:19074 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1752425AbWCPRJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:09:51 -0500
X-ME-UUID: 20060316170947759.B941C1C00D11@mwinf0108.wanadoo.fr
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
From: Xavier Bestel <xavier.bestel@free.fr>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, aia21@cantab.net,
       len.brown@intel.com
In-Reply-To: <20060316160129.GB6407@infradead.org>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
	 <20060316160129.GB6407@infradead.org>
Content-Type: text/plain
Message-Id: <1142528980.22772.36.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 16 Mar 2006 18:09:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 17:01, Christoph Hellwig wrote:
> > The patch implements TRUE and FALSE in include/linux/kernel.h and removes all
> > the private versions.
> > 
> > The patch also kills off a few private implementations of NULL.
> 
> NACK.  Just kill them all and use 0/1

I'd say use var == 0 and var != 0 (or var and !var).
While FALSE is obviously 0, TRUE isn't only 1.

	Xav


