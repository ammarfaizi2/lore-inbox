Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWBQOxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWBQOxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWBQOxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:53:08 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:9461 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964913AbWBQOxG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:53:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HzKZApnzYO6dgO1dOSIyqT6lg50mXHJzpAFcMojHzYDARx10JdnunjRyOrv34bdBz35tcsNHggUwlMWkHQe5xG+r4YbLebzm7TDM6ygukkrBEcDdt+KDXItRg9VZ8yQXNco7QKzyU6N5l9pliHup+VSgXQ6RzvyBVc0lVyI0IlQ=
Message-ID: <58cb370e0602170653g30bd36f3j4b1a0e95f64ecbeb@mail.gmail.com>
Date: Fri, 17 Feb 2006 15:53:04 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Fix IDE locking error.
Cc: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <1140186532.4283.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060216223916.GA8463@redhat.com>
	 <58cb370e0602170057x59b23957n3e858d5ac4918326@mail.gmail.com>
	 <1140186532.4283.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2006-02-17 at 09:57 +0100, Bartlomiej Zolnierkiewicz wrote:
> > Could we get a decent description of the problem and of the patch?
>
> Audit the lock state on all entries to the tune function and it
> certainly was the case that the old IDE layer could call it with the
> lock either already held or not.

Thank you but this is not a patch description, this is a recipe
for me to spend nice friday's evening staring all over IDE code
and making patch description myself...

http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt ?

Bartlomiej
