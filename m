Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVDSKNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVDSKNW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 06:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDSKNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 06:13:22 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:3233 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261445AbVDSKNT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 06:13:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=io8qIhFRoVA57wkveEt14Exnfj4Dd5F77eVkZ3CvEKsvXE7eGoIsCwtOyYLVvEsB6tBAs3VctY7vKgKWXi78+N4SFhXh/I+ykKmmlnKmIXLlaZnQDia3FXqjAUO+fA5IAcbYj9iKHnavFh7+c7Ftf0GW7nW0ND1EtCDiKAe3C8o=
Message-ID: <6f6293f105041903134025da80@mail.gmail.com>
Date: Tue, 19 Apr 2005 12:13:19 +0200
From: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Reply-To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
To: Linda Luu <linda.luu@comcast.net>
Subject: Re: Multi-core, Vanderpool support?
Cc: linux-kernel@vger.kernel.org,
       "Nguyen, Nguyen (Home)" <ndnguyen3@comcast.net>
In-Reply-To: <004901c541d9$16b18ad0$6501a8c0@Jaguar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <004901c541d9$16b18ad0$6501a8c0@Jaguar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/05, Linda Luu <linda.luu@comcast.net> wrote:
> Hello,
> 
> Does anyone happen to know how the upcoming multi-core CPU will be handled
> by the kernel?  Does it see each core as a physical or logical CPU or ?

Can't answer this, but I guess each core will be seen as a physical
CPU as they are real CPU cores, not just logical CPUs as with
multithreading.
 
> Vanderpool is a hardware support for OS virtualization (running multiple OS
> "at the same time"), how does Linux kernel make use of this, particularly
> which part of the kernel code?

At least, Xen will make great use of Vanderpool (VT) for
virtualization purpouses.
