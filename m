Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWCZVsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWCZVsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWCZVsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:48:33 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:15973 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932141AbWCZVsc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:48:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b6QC5qJTXxQ6RVBH4MTz9xfSwYZ3/u8GcvNMlEE+mWGbJz/23PP+0Q6AQiJYbTY5mzVhZpf5mPffvldwe3iGD9din5FE+LRgHoDfRWzDTUeZdcFYJbBJM9cTqAlhz7ooW2shLN3MUT0aY2SKWzPUVKMRIz39KtjWVQlfQ0BxEig=
Message-ID: <bda6d13a0603261348t62aad445u88e6d535c56f264e@mail.gmail.com>
Date: Sun, 26 Mar 2006 13:48:32 -0800
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
In-Reply-To: <20060326152044.GV31387@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060225160150.GX3674@stusta.de> <20060225224631.GA4085@suse.de>
	 <20060325194739.GS4053@stusta.de> <20060326152044.GV31387@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a dumb idea. Why not export said symbols only if CONFIG_UNIX=m.
Probably dumb because I know the pain of an important symbol not being exported.
In my case, it was __iget(struct inode *).
