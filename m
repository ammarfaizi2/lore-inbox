Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVG2AlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVG2AlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVG2AlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:41:25 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:9239 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262248AbVG2AlN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:41:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qFsZpIgPWQcqGzMsPbxiOzr6evincEg8CdLxhdFZRXtpw0d2H5Pjizs6hxNl9WHFiOXul/OdYORr030NqzGX2BvNMjWn4/wwNTLqMqEMMzReLJpM0WG7H/cbKy0SPBncLKXdFfiv9M8zTQxy95x0uGWIsgr95hRlZJ3nIsFaqSw=
Message-ID: <21d7e9970507281741fb51c98@mail.gmail.com>
Date: Fri, 29 Jul 2005 10:41:10 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.6.13-rc3-mm2/mm1 breaks DRI
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200507282037.52292.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050727024330.78ee32c2.akpm@osdl.org>
	 <200507271758.52466.tomlins@cam.org>
	 <200507282037.52292.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > >Hmm no idea what could have broken it, I'm at OLS and don't have any
> > >DRI capable machine here yet.. so it'll be a while before I get to
> > >take a look at it .. I wouldn't be terribly surprised if some of the
> > >new mapping code might have some issues..
> >
> > Still happens with mm2.
> 
> And mm3 too.  Please let me know if there is anything you would like me to try.

Hi Ed,

Is this all on a 64-bit system, is it a pure 64-bit or are you running
a 32-bit userspace or something like that... I don't have any 64-bit
systems so tracking the issues on them is a nightmare...

I've got a patch from Egbert Eich that I need to drop into -mm that
might fix it but I'm snowed under with real work at the moment (taking
a week off for OLS didn't help :-)

Dave.
