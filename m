Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUFRXhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUFRXhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUFRXd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:33:58 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:2962 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S265785AbUFRXcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:32:36 -0400
Date: Sat, 19 Jun 2004 00:31:51 +0100
From: Ian Molton <spyro@f2s.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040619003151.04e67b07.spyro@f2s.com>
In-Reply-To: <1087600052.2135.197.camel@mulgrave>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.co
	m>
	<40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com>
	<1087588627.2134.155.camel@mulgrave>
	<40D359BB.3090106@pacbell.net>
	<1087593282.2135.176.camel@mulgrave>
	<40D36EDE.2080803@pacbell.net>
	<1087600052.2135.197.camel@mulgrave>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2004 18:07:30 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> 
> Well, yes, but the problem: chips have onboard memory is generic.  The
> proposed solution in the DMA API can't only work on certain platforms.

It will work on any platform where the memory is directly visible to the
CPU...

if this sint the case its not *D* MA (ie. *direct* memory access is it?
