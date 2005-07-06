Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVGFRYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVGFRYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 13:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVGFRW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 13:22:56 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:24717 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261670AbVGFM6g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:58:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kOTQZk3hymDhUo8Qhl/D09Y3rrdKZ8qkezBKIYK94JWz84+LEC3LPgt6eYAC1SkfkI4G70yl8rBTsusxagaeINvXum4trdPcIJX2nAsAaCK/dpBtl/sR/jBR2i/4mzNHBwLQJmdU1qrQfxG4M4PgYC1Z53dRVrSUyUD9tnhQDt4=
Message-ID: <9a874849050706055831ec5aae@mail.gmail.com>
Date: Wed, 6 Jul 2005 14:58:34 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Rob Prowel <tempest766@yahoo.com>
Subject: Re: PROBLEM: please remove reserved word "new" from kernel headers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Rob Prowel <tempest766@yahoo.com> wrote:
> [1.] One line summary of the problem:
> 
> 2.4 and 2.6 kernel headers use c++ reserved word "new"
> as identifier in function prototypes.
> 
"new" is not a reserved word in C. the kernel is written in C.


> [2.] Full description of the problem/report:
> 
> When kernel headers are included in compilation of c++
> programs the compile fails because some header files
> use "new" in a way that is illegal for c++.

Userspace programs should not include kernel headers directly.

But, if you really want it changed I suggest you create a patch and
submit that for review/inclusion and see what feedback you get.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
