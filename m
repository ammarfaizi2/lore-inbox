Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291542AbSBAEgT>; Thu, 31 Jan 2002 23:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291543AbSBAEgA>; Thu, 31 Jan 2002 23:36:00 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25487 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291541AbSBAEfq>;
	Thu, 31 Jan 2002 23:35:46 -0500
Date: Thu, 31 Jan 2002 23:35:44 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020131233544.A23792@havoc.gtf.org>
In-Reply-To: <20020131.162549.74750188.davem@redhat.com> <E16WRmu-0003iO-00@the-village.bc.nu> <20020131.163054.41634626.davem@redhat.com> <a3d4tp$nlu$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a3d4tp$nlu$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Jan 31, 2002 at 08:18:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 08:18:01PM -0800, H. Peter Anvin wrote:
> It *does* mean the configure rules need to contain these dependencies,
> though.

No.  The Makefile not configure needs to mention these dependencies.

Look at how crc32 is -really- included in the kernel.

	Jeff



