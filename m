Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264296AbUE2OcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUE2OcG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUE2OcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:32:06 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50887 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264297AbUE2Obl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:31:41 -0400
Date: Sat, 29 May 2004 16:31:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler version
Message-ID: <20040529143135.GR16099@fs.tum.de>
References: <20040529111616.A16627@electric-eye.fr.zoreil.com> <20040529115238.A17267@electric-eye.fr.zoreil.com> <200405291330.i4TDUhsN000547@81-2-122-30.bradfords.org.uk> <20040529161247.A19214@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529161247.A19214@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 04:12:47PM +0200, Francois Romieu wrote:
>...
> It makes no sense to religiously recommended 2.95.3 if it is known broken.

In my experience, 2.95.3 isn't more broken than the average 3.3 
compiler.

> If nobody comes with a better approach, I'll simply submit a patch to
> remove the 2.95.3 recommendation (+ #error for the driver as suggested by ak).

The common solution in the kernel for such issues is to change the code 
to compile correctly with all supported compilers.

This might not be a perfect solution, but otherwise different drivers 
might require different compiler versions resulting in a chaos.

Whether support for gcc 2.95 should be dropped is a discussion for 2.7.

> Ueimor

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

