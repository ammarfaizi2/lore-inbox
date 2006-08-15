Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWHOByQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWHOByQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 21:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWHOByQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 21:54:16 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:17908 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751400AbWHOByP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 21:54:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=IQx8cwq2gAMZIq04Hj5GtVPnHuykW8pqTVofxwfpOzNhTSso9NA+yOGsk4dcy7bvshl2ULOzszqyntlQIUC4f13LnvVleGe5Mr29Lnuj+ZGo64fLxQNwERBdD67PJn1OJh0/QH4fZkkkH3/gd611td5Ny6bScn6vsugYkAIdWQI=
Subject: Re: vga text console
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: James C Georgas <jgeorgas@rogers.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1155606109.8131.13.camel@Rainsong>
References: <1155604313.8131.4.camel@Rainsong>
	 <1155604928.3948.8.camel@daplas.org>  <1155605197.3948.10.camel@daplas.org>
	 <1155606109.8131.13.camel@Rainsong>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 09:54:09 +0800
Message-Id: <1155606849.3948.17.camel@daplas.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 21:41 -0400, James C Georgas wrote:
> On Tue, 2006-15-08 at 09:26 +0800, Antonino A. Daplas wrote:
> > On Tue, 2006-08-15 at 09:22 +0800, Antonino A. Daplas wrote:
> > > On Mon, 2006-08-14 at 21:11 -0400, James C Georgas wrote:
> > > > I can't seem to remove the VGA text console from my kernel
> > > > configuration. Can someone please enlighten me?
> > > 
> > > You can't. It is always part of the kernel (for X86 at least). What's
> > > your intention?
> 
> I want to write my own VGA text console driver.
> 
> > And correcting myself, you can configure out vgacon, but you have to
> > define CONFIG_EMBEDDED, and undefine CONFIG_VT.
> > 
> If I define CONFIG_EMBEDDED, is that going to change the behaviour of
> other subsystems, or does it just enable more options?
> 

It basically opens up a lot of config options. It may also disable a few
incompatible options (ie, CONFIG_DEBUG_VERBOSE), and enable a few.  It
will require that you know exactly what options need to be turned on or
off.

Tony

