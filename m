Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290828AbSAaB5i>; Wed, 30 Jan 2002 20:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290827AbSAaB53>; Wed, 30 Jan 2002 20:57:29 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39394 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290825AbSAaB5Q>;
	Wed, 30 Jan 2002 20:57:16 -0500
Date: Wed, 30 Jan 2002 20:57:14 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
Message-ID: <20020130205714.B20698@havoc.gtf.org>
In-Reply-To: <20020130201754.B18730@havoc.gtf.org> <7417.1012441910@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7417.1012441910@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, Jan 31, 2002 at 12:51:50PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 12:51:50PM +1100, Keith Owens wrote:
> tend not to live very long.  Christoph Hellwig suggested a Makefile
> change that prevents kernel code including user space headers, it is
> included in kbuild 2.5 and there is a 2.4 version in
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=100321690511549&w=2

Patch looks ok to me...  The only thing I wonder is if we should put
kernel includes before gcc includes, just in case we want to override
something.

I would support putting this in the default cflags for 2.4 and 2.5...

	Jeff



