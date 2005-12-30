Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVL3G6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVL3G6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 01:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVL3G6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 01:58:49 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:22297 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751196AbVL3G6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 01:58:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CahCUPyzoBu/wNQkWGgBKmsryY5LeR6ahXiUulMOx333Dj/+4mdjR2xfiwoxVDqpsVmcNM9AKJMv1NdKhwBdU/F82wAoOQ7iApzxxCbwsiqOBJldSHcN64YjizQRpTKvo5y3LRToWwP9iFm402caDHxUTEhMx+uWndiEOSdmg4Y=
Message-ID: <5a4c581d0512292258y3fe00ff8ufae3188df18f5368@mail.gmail.com>
Date: Fri, 30 Dec 2005 07:58:48 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: Re: Howto set kernel makefile to use particular gcc
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B223997@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3AEC1E10243A314391FE9C01CD65429B223997@mail.esn.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Mukund JB. <mukundjb@esntechnologies.co.in> wrote:
>
> Dear Kernel mailers,
>
> I have specific requirement of building kernel 2.6.11.12 with gcc- 3.3 over the FC4 dist.
> I have downloaded the gcc-3.3.
> As FC4 comes with a default gcc-4.0, how do I set the kernel Makefile to use the gcc-3.3 instead of gcc-4.0.
>
> How do I achieve it? I know it is a very small issue and searched google and I am unable to find it.

Leave the kernel Makefile alone, and say

cd /usr/src/linux
make CC=<path_to_your_gcc_3.3>

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
