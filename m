Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265781AbUFRX2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265781AbUFRX2c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUFRX2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:28:31 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:59279 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S265773AbUFRX0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:26:11 -0400
Date: Sat, 19 Jun 2004 00:25:22 +0100
From: Ian Molton <spyro@f2s.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040619002522.0c0d8e51.spyro@f2s.com>
In-Reply-To: <1087588627.2134.155.camel@mulgrave>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.com>
	<40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com>
	<1087588627.2134.155.camel@mulgrave>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2004 14:57:01 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> 
> There are complications to this: not all platforms can access PCI memory
> directly.  That's why ioremap and memcpy_toio and friends exist.  What
> should happen on these platforms?

I wasnt talking about a PCI system here.
