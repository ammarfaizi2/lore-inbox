Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbVLVJeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVLVJeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 04:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVLVJeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 04:34:10 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:20288 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965146AbVLVJeI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 04:34:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iVIgEqHO6jxGKgK6U8GSKRNYGU1IXIebmXS6sRfP4nFz0Ef8tgho89YDlDkw5EReJtASVNUfyMDLMwFhkMNS6irXRom2XI0bpZ0N5TogkyGfP6H83T51omHjo+cz5D5kVkTWvgXkcwF2XYGrGd6TfqguTGD/facNGYmr8Ff5gNU=
Message-ID: <c216304e0512220134n68a081d1k7d8f6a6d1e546d4f@mail.gmail.com>
Date: Thu, 22 Dec 2005 15:04:07 +0530
From: Ashutosh Naik <ashutosh.lkml@gmail.com>
To: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [BUG] Early Kernel Panic with 2.6.15-rc5
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       ashutosh.naik@gmail.com, linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20051214144728.A32611@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450512102211r608cee8wc16cc19565a1488f@mail.gmail.com>
	 <20051210223453.24f7515b.akpm@osdl.org>
	 <20051211095506.176a26ae.rdunlap@xenotime.net>
	 <20051214144728.A32611@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/05, Rajesh Shah <rajesh.shah@intel.com> wrote:
> On Sun, Dec 11, 2005 at 09:55:06AM -0800, Randy.Dunlap wrote:

> Actually, this is already fixed here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113434648617851&w=2

This BUG looks fixed in 2.6.15-rc6 as no crash occurs even if 
CONFIG_HOTPLUG_PCI_PCIE=y.

Regards
Ashutosh
