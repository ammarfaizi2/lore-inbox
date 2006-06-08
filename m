Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWFHGvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWFHGvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 02:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWFHGvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 02:51:33 -0400
Received: from mail.suse.de ([195.135.220.2]:58595 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932542AbWFHGvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 02:51:32 -0400
From: Andi Kleen <ak@suse.de>
To: bidulock@openss7.org
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
Date: Thu, 8 Jun 2006 08:51:20 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
References: <20060607173642.GA6378@schatzie.adilger.int> <200606080739.33967.ak@suse.de> <20060608004153.A11953@openss7.org>
In-Reply-To: <20060608004153.A11953@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606080851.20232.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 08:41, Brian F. G. Bidulock wrote:
> Andi,
> 
> On Thu, 08 Jun 2006, Andi Kleen wrote:
> > 
> > Nothing on x86-64 at least - it uses -fno-reorder-blocks by default.
> > 
> 
> Why is that?

Originally because it made assembly too unreadable. Later it was discovered
it produces smaller code too.

-Andi
