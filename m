Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbTEMPJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTEMPJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:09:38 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:56718 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261181AbTEMPJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:09:36 -0400
Date: Tue, 13 May 2003 16:22:28 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513152228.GA4388@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <shswugvjcy9.fsf@charged.uio.no> <20030513135756.GA676@suse.de> <16065.3159.768256.81302@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16065.3159.768256.81302@charged.uio.no>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:16:39PM +0200, Trond Myklebust wrote:
 > >>>>> Dave Jones <davej@codemonkey.org.uk> writes:
 > 
 >      > I can still kill an NFS server in under a minute with fsx.
 > 
 > I'm more interested in hearing how the client fixes are coping.
 > i.e. is the client recovering properly if/when you restart the server
 > after such a crash?

After a crash, I can carry on using that export just fine.
unexporting and reexporting also works fine.
Perhaps 'kill' was an over-strong word to use above, lets
replace it with 'make it break causing possible fs corruption'.

		Dave

