Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVK0Br0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVK0Br0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 20:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVK0Br0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 20:47:26 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:5909 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750815AbVK0BrZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 20:47:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lJnQPJ+6i+xu9UqmMW4UlKl3RdPmUL0Si4gt0l2BW8k3kA8MvL1xgrYMhhEGUdrrBT/VEeq9fLfzFOxLXayDBl4c8uO5bmQYqVJPyuE7G2W+mRJF29UfngjofK9CpwJBTnqvE7i6cd2ERPzv5wyz6LAi9mDIIvFmmajc4BAXUnE=
Message-ID: <9c21eeae0511261747q467a4676ne1347c3f77d3e4f@mail.gmail.com>
Date: Sat, 26 Nov 2005 17:47:22 -0800
From: David Brown <dmlb2000@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200511270138.25769.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <200511262346.27907.s0348365@sms.ed.ac.uk>
	 <9c21eeae0511261713vacf13f5u5fdf19711635a381@mail.gmail.com>
	 <200511270138.25769.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure enough, I can confirm this.
>
> I don't seem to have to provide --no-same-permissions to tar to get umask to
> affect the permissions of extracted files, so my files are fine on-disc.

yeah it's a pretty easy fix on the system and it's a pretty easy fix
for the mirror, just needs to happen.

> What disturbs me more is the number of people using insecure umasks before
> checking files in! When does a text file really want to be a+w?

agreed many people compile and install their own kernels without using
their distros package manager to do it, I've sent emails to my distro
about the permissions problem with that tarball.

- David Brown
