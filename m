Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317795AbSFSHBr>; Wed, 19 Jun 2002 03:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317796AbSFSHBq>; Wed, 19 Jun 2002 03:01:46 -0400
Received: from [148.246.77.237] ([148.246.77.237]:772 "EHLO zion.sytes.net")
	by vger.kernel.org with ESMTP id <S317795AbSFSHBq>;
	Wed, 19 Jun 2002 03:01:46 -0400
Date: Wed, 19 Jun 2002 02:01:35 -0500
From: Felipe Contreras <al593181@mail.mty.itesm.mx>
To: linux-kernel@vger.kernel.org
Cc: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
Subject: Re: Weird make bug in 2.5.22
Message-ID: <20020619070135.GA124@zion.mty.itesm.mx>
References: <20020618064056.GA2456@zion.mty.itesm.mx> <20020618064526.GA27319@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020618064526.GA27319@linux.kappa.ro>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 09:45:26AM +0300, Teodor Iacob wrote:
> 139 return code means that the process that make was running
> crashed with signal 11 ( 128 + 11 ) Segmentation Fault so 
> perhaps you have some other kind of problems? like a faulty machine?

If you consider a "faulty machine" a development one, then yes, I have one. I
have glibc-2.2.5 gcc-3.1 linux-2.5.23, but that shouldn't matter I want to know
what's causing this and I'll like to fix it.

I'm pretty sure this started with linux-2.5.19, might be it has something to do
with forking, might be it's a make bug, but I think something is wrong here.

-- 
Felipe Contreras
