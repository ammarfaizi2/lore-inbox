Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWC2Xuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWC2Xuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWC2Xuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:50:32 -0500
Received: from palrel10.hp.com ([156.153.255.245]:13994 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751289AbWC2Xub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:50:31 -0500
Date: Wed, 29 Mar 2006 15:50:53 -0800
From: Grant Grundler <iod00d@hp.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Christoph Lameter'" <clameter@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       Zoltan Menyhart <Zoltan.Menyhart@free.fr>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
Message-ID: <20060329235053.GC541@esmail.cup.hp.com>
References: <Pine.LNX.4.64.0603291529160.26011@schroedinger.engr.sgi.com> <200603292348.k2TNmNg12952@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603292348.k2TNmNg12952@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 03:49:08PM -0800, Chen, Kenneth W wrote:
> Is gcc smart enough to turn constant argument and collapse inline of
> inline function?  I hope it does.

Yes, I'm pretty sure at -O2 (normal kernel usage) it is.

grant
