Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVALVT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVALVT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVALVN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:13:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44010 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261463AbVALVKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:10:39 -0500
Date: Wed, 12 Jan 2005 16:09:45 -0500
From: Dave Jones <davej@redhat.com>
To: Roland Dreier <roland@topspin.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: debugfs directory structure
Message-ID: <20050112210945.GN24518@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Roland Dreier <roland@topspin.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org, openib-general@openib.org
References: <52d5watlqs.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d5watlqs.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 12:50:51PM -0800, Roland Dreier wrote:
 > Hi Greg,
 > 
 > Now that debugfs is merged into Linus's tree, I'm looking at using it
 > to replace the IPoIB debugging pseudo-filesystem (ipoib_debugfs).  Is
 > there any guidance on what the structure of debugfs should look like?
 > Right now I'm planning on putting all the debug info files under an
 > ipoib/ top level directory.  Does that sound reasonable?

How about mirroring the toplevel kernel source structure ?

Ie, you'd make drivers/infiniband/ulp/ipoib ?

It could get ugly quickly without some structure at least to
the toplevel dir.

		Dave

