Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVI3Rop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVI3Rop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVI3Rop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:44:45 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:55031 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932471AbVI3Roo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:44:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=CohFGty8JYfAltKoyctMpYy1K9Makg8h4T4pH9DfBXyRGKn4EpMUACwDD4jnPGAScVVKC0xXy+bLlX33PZjy3EnzgIOx8NjAbjiP6fRBlolQqELywNjZApm1YuVHe80NHOUjP1/b1oz9QVs1dzWT5/gqlJNeQhqqOpIsM7jB/Ps=
Date: Fri, 30 Sep 2005 21:55:50 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cross-toolchain (Gentoo)
Message-ID: <20050930175550.GA24071@mipter.zuzino.mipt.ru>
References: <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20050930125645.GJ7992@ftp.linux.org.uk> <20050930160911.GA24810@mipter.zuzino.mipt.ru> <20050930160503.GK7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930160503.GK7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 05:05:03PM +0100, Al Viro wrote:
> On Fri, Sep 30, 2005 at 08:09:11PM +0400, Alexey Dobriyan wrote:
> > 1) Watch for it to install gcc 3.4.*. Chances of successful build are much
> >    higher than with 3.3. Use --g switch of crossdev (_especially_ with
> >    s390).
> 
> Umm...  Is crossdev toolchain with target==host the same as native one?

Not sure what do you mean... Native gcc here is 3.3.6.

	# crossdev -p -v -s1 -t i686-unknown-linux-gnu

will install binutils-2.16.1 and gcc-3.4.4.

