Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWHNFpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWHNFpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 01:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWHNFpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 01:45:23 -0400
Received: from ns1.suse.de ([195.135.220.2]:12418 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751442AbWHNFpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 01:45:22 -0400
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: module compiler version check still needed?
Date: Mon, 14 Aug 2006 07:45:14 +0200
User-Agent: KMail/1.9.3
Cc: Matthew Wilcox <matthew@wil.cx>, Keith Owens <kaos@ocs.com.au>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <31645.1155445159@ocs10w.ocs.com.au> <200608140659.49462.ak@suse.de> <20060814053831.GA23871@mars.ravnborg.org>
In-Reply-To: <20060814053831.GA23871@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608140745.14435.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 07:38, Sam Ravnborg wrote:
> On Mon, Aug 14, 2006 at 06:59:49AM +0200, Andi Kleen wrote:
>  > 
> > > Will we remember to add the check back in when we introduce new
> > > dependencies on compiler versions?
> > 
> > If something breaks it be readded. I see it only as a special
> > hack for some extraordinary, and hopefully these problems won't happen again.
> What we should add should be some kind of cabability mask.

It would be probably overkill.

> There is no need to require that modules are built with exactly the same
> compiler as the kernel when it is only a very few compiler versions that
> causes layout/ABI differences.

On i386/x86-64 that's not the case anymore as far as I know.

-Andi
