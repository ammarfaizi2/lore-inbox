Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbSJVGE0>; Tue, 22 Oct 2002 02:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262240AbSJVGEZ>; Tue, 22 Oct 2002 02:04:25 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:13578 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262239AbSJVGEX>;
	Tue, 22 Oct 2002 02:04:23 -0400
Date: Mon, 21 Oct 2002 23:09:20 -0700
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
Message-ID: <20021022060920.GA3520@kroah.com>
References: <1035204505.27318.81.camel@irongate.swansea.linux.org.uk> <F2DBA543B89AD51184B600508B68D4000E6AE154@fmsmsx103.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000E6AE154@fmsmsx103.fm.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 08:56:49AM -0700, Nakajima, Jun wrote:
> 
> In the kernel, there are several device drivers (ftape-bsm.h, e100.h, for
> example) are doing this kind of thing (i.e. typedef + attribute). 

All the more reason to not use typedefs in the kernel :)

(sorry, I could not help myself...)

greg k-h
