Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUFOV2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUFOV2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUFOV2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:28:55 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:32004 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265974AbUFOV1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:27:52 -0400
Subject: Re: Bug#253590: How to turn off IPV6 (link local)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Bernd Eckenfels <be-mail2004@lina.inka.de>
Cc: linux-kernel@vger.kernel.org, Trent Lloyd <lathiat@bur.st>,
       253590@bugs.debian.org
In-Reply-To: <20040615194657.GA7474@lina.inka.de>
References: <20040614233215.GA10547@lina.inka.de>
	 <20040615023022.GB24269@thump.bur.st>  <20040615194657.GA7474@lina.inka.de>
Content-Type: text/plain
Date: Tue, 15 Jun 2004 23:27:58 +0200
Message-Id: <1087334878.1689.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-15 at 21:46 +0200, Bernd Eckenfels wrote:

> So I think autoconf=0 should avoid  adding the 3ff8 link local  address (as
> well as lo ::1)

3ff8 a link local address? I think you're wrong. Link local addresses
have the fe80:: prefix. 3ff8::/64 is a global unicast IPv6 address.

