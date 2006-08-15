Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932748AbWHOBlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbWHOBlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 21:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWHOBlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 21:41:09 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:19049 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932748AbWHOBlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 21:41:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=djpRZlalWiWIrX/2HBs66Ecm1zac2lzRAX1AA4+MA3Dyqabxxv0bFBeU4SSbyIAimh+rMIbeyMRWJ/2QEk7HGORERR/zN6QIm0txT4naNROroyG30TGX25Mt6FXckg2sauKSHmBm2QGMxbaFnaZJiR9TUZt6XcrVECVodQP7NmA=  ;
Subject: Re: vga text console
From: James C Georgas <jgeorgas@rogers.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1155605197.3948.10.camel@daplas.org>
References: <1155604313.8131.4.camel@Rainsong>
	 <1155604928.3948.8.camel@daplas.org>  <1155605197.3948.10.camel@daplas.org>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 21:41:49 -0400
Message-Id: <1155606109.8131.13.camel@Rainsong>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-15-08 at 09:26 +0800, Antonino A. Daplas wrote:
> On Tue, 2006-08-15 at 09:22 +0800, Antonino A. Daplas wrote:
> > On Mon, 2006-08-14 at 21:11 -0400, James C Georgas wrote:
> > > I can't seem to remove the VGA text console from my kernel
> > > configuration. Can someone please enlighten me?
> > 
> > You can't. It is always part of the kernel (for X86 at least). What's
> > your intention?

I want to write my own VGA text console driver.

> And correcting myself, you can configure out vgacon, but you have to
> define CONFIG_EMBEDDED, and undefine CONFIG_VT.
> 
If I define CONFIG_EMBEDDED, is that going to change the behaviour of
other subsystems, or does it just enable more options?

