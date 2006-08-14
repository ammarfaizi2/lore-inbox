Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWHNFix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWHNFix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 01:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWHNFix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 01:38:53 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:57835 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751046AbWHNFit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 01:38:49 -0400
Date: Mon, 14 Aug 2006 07:38:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Keith Owens <kaos@ocs.com.au>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: module compiler version check still needed?
Message-ID: <20060814053831.GA23871@mars.ravnborg.org>
References: <31645.1155445159@ocs10w.ocs.com.au> <200608132227.24719.ak@suse.de> <20060813221456.GC789@parisc-linux.org> <200608140659.49462.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608140659.49462.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 06:59:49AM +0200, Andi Kleen wrote:
 > 
> > Will we remember to add the check back in when we introduce new
> > dependencies on compiler versions?
> 
> If something breaks it be readded. I see it only as a special
> hack for some extraordinary, and hopefully these problems won't happen again.
What we should add should be some kind of cabability mask.
There is no need to require that modules are built with exactly the same
compiler as the kernel when it is only a very few compiler versions that
causes layout/ABI differences.

	Sam
