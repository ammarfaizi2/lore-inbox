Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbTBTAr0>; Wed, 19 Feb 2003 19:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTBTAr0>; Wed, 19 Feb 2003 19:47:26 -0500
Received: from tapu.f00f.org ([202.49.232.129]:56208 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S261173AbTBTArZ>;
	Wed, 19 Feb 2003 19:47:25 -0500
Date: Wed, 19 Feb 2003 16:57:29 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Tom Lendacky <toml@us.ibm.com>,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPSec protocol application order
Message-ID: <20030220005729.GA22880@f00f.org>
References: <OF67D9F550.2E100257-ON86256CD2.007CE0BF-86256CD2.007E9FBD@pok.ibm.com> <1045704729.14999.2.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045704729.14999.2.camel@rth.ninka.net>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 05:32:09PM -0800, David S. Miller wrote:

> ... Do you suggest that the kernel or some other part of the system
> should verify the packets sent through the RAW socket interface?
> That is exactly what you are telling us that setkey should be doing.

someone could patch setkey to warn if it's told to do something bogus,
with optional command line switch to silence this or whatever


  --cw
