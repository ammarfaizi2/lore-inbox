Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUFRXhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUFRXhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUFRXdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:33:31 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:60625 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262138AbUFRX32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:29:28 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: david-b@pacbell.net, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com
In-Reply-To: <20040619002522.0c0d8e51.spyro@f2s.com>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.com> <40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com>
	<1087588627.2134.155.camel@mulgrave> 
	<20040619002522.0c0d8e51.spyro@f2s.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 18:29:22 -0500
Message-Id: <1087601363.2078.208.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 18:25, Ian Molton wrote:
> On 18 Jun 2004 14:57:01 -0500
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> > There are complications to this: not all platforms can access PCI memory
> > directly.  That's why ioremap and memcpy_toio and friends exist.  What
> > should happen on these platforms?
> 
> I wasnt talking about a PCI system here.

ioremap is used for all bus remote MMIO regions, not just PCI.

James


