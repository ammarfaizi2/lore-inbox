Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbTFEQqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbTFEQqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:46:53 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:31158 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S264750AbTFEQqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:46:51 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: dm-devel@sistina.com, Kevin Corry <kevcorry@us.ibm.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC] device-mapper ioctl interface
Date: Thu, 5 Jun 2003 19:00:37 +0200
User-Agent: KMail/1.5.2
References: <20030605093943.GD434@fib011235813.fsnet.co.uk> <200306051147.10775.kevcorry@us.ibm.com>
In-Reply-To: <200306051147.10775.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306051900.37276.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 June 2003 18:47, Kevin Corry wrote:
> 2) Removing suspended devices. The current code (2.5.70) does not allow a
> suspended device to be removed/unlinked from the ioctl interface, since
> removing it would leave you with no way to resume it (and hence flush any
> pending I/Os). Alasdair mentioned a couple of new ideas. One would be to
> reload the device with an error-map and force it to resume, thus erroring
> any pending I/Os and allowing the device to be removed. This seems a bit
> heavy-handed.

Which is the heavy-handed part?

Regards,

Daniel

