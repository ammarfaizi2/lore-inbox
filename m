Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWIEQsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWIEQsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWIEQsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:48:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:29068 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030189AbWIEQsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:48:09 -0400
Subject: Re: [RFC][PATCH 3/9] actual generic PAGE_SIZE infrastructure
From: Dave Hansen <haveblue@us.ibm.com>
To: Martin Waitz <tali@admingilde.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <20060905112056.GJ17042@admingilde.org>
References: <20060830221604.E7320C0F@localhost.localdomain>
	 <20060830221606.40937644@localhost.localdomain>
	 <20060905112056.GJ17042@admingilde.org>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 09:47:43 -0700
Message-Id: <1157474863.3186.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 13:20 +0200, Martin Waitz wrote:
> On Wed, Aug 30, 2006 at 03:16:06PM -0700, Dave Hansen wrote:
> > * Define ASM_CONST() macro to help using constants in both assembly
> >   and C code.  Several architectures have some form of this, and
> >   they will be consolidated around this one.
> 
> arm uses UL() for this and I think this is much more readable than
> ASM_CONST().  Can we please change the name of this macro?

I don't have any real problem with changing it, but I fear that the ppc
guys will want it the _other_ way. ;)

Do you really mind if we just keep it as it is?  If there is some
further disagreement on it, I'll change it.

-- Dave

