Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310534AbSCLJtZ>; Tue, 12 Mar 2002 04:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310536AbSCLJtP>; Tue, 12 Mar 2002 04:49:15 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:53993 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S310534AbSCLJtF>; Tue, 12 Mar 2002 04:49:05 -0500
Date: Tue, 12 Mar 2002 11:48:45 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zlib vulnerability and modutils
Message-ID: <20020312094845.GE128921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <4394.1015887380@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394.1015887380@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 09:56:20AM +1100, you [Keith Owens] wrote:
> Content-Type: text/plain; charset=us-ascii
> 
> A double free vulnerability has been found in zlib which can be used in
> a DoS or possibly in an exploit.  Distributions are now shipping
> upgraded versions of zlib, installing the new version of zlib will fix
> programs that use the shared library.
> 
> modutils has an option --enable-zlib which lets modprobe and insmod
> read modules that have been compressed with gzip.  If you built your
> modutils with --enable-zlib and are using insmod.static then you must
> rebuild modutils after first upgrading zlib.  This only applies if
> modutils was built with --enable-zlib (the default is not to use zlib)
> and you also use static versions of modutils.

I'm propably missing something, but if you load untrusted kernel modules
(compressed or not), isn't the zlib vulnerability least of your concerns?



-- v --

v@iki.fi
