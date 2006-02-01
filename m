Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWBAAMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWBAAMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWBAAMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:12:07 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:57931 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751225AbWBAAMG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:12:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gMpNwN5abPvITgt83C7JeWW+qUdA/JNPTDLGXbz8h5g+xpv2sjtp+PGo2L0p/tRJJWCSAoDynnBdtnr4qQvnew84eAqPqavxaQQGUZyu6apW/1HzmuCFuv3jJAjs/IpjuNgjTLQIoHhik4RGvpHI7nD4Mt/w/EqTP0kXmSMH6bE=
Message-ID: <f383264b0601311612w4402043eh985b7ba8c8bbe14c@mail.gmail.com>
Date: Tue, 31 Jan 2006 16:12:03 -0800
From: Matt Reimer <mattjreimer@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: LED: Add IDE disk activity LED trigger
In-Reply-To: <20060131212249.GR31163@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060131203552.GG4215@suse.de>
	 <20060131212249.GR31163@cosmic.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Jordan Crouse <jordan.crouse@amd.com> wrote:
> On 31/01/06 21:35 +0100, "Jens Axboe" wrote:
> > Perhaps a generic solution isn't feasible, because this isn't really a
> > generic problem. The LED stuff has very limited use - you mention
> > embedded platforms, perhaps they should just be doing this on their own?
>
> Possibly, but what you'll find is that many different embedded platforms
> end up wanting similar behavior, and if they all do it on their own, that
> ends up in a mess.

Indeed. This LED code is exactly what we need for just about every
linux handheld in existence. Please include it.

Matt
