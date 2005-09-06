Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVIFVUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVIFVUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbVIFVUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:20:15 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:5398 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750969AbVIFVUO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:20:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O0/7RtE8sVL6rFNdovoVd39v0bAo+jfJZ3+MaFLo/OJrYuA0hUv4uHBWO3qXz5WxzdAm4d8hfUHdcNwnNtnlGpZ1RKwz2+FFWzU4kPximxuKQNMIQrbVlP7qdvrILoOIkwsDpgDe0yqcR8mCTU6yFemT2QJ6v92jPb85+nqRYQE=
Message-ID: <9a87484905090614204ba36b83@mail.gmail.com>
Date: Tue, 6 Sep 2005 23:20:12 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Budde, Marco" <budde@telos.de>
Subject: Re: kbuild & C++
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, Budde, Marco <budde@telos.de> wrote:
> Hi,
> 
> for one of our customers I have to port a Windows driver to
> Linux. Large parts of the driver's backend code consists of
> C++.
> 
> How can I compile this code with kbuild? The C++ support
> (I have tested with 2.6.11) of kbuild seems to be incomplete /
> not working.
> 

That would be because the kernel is written in *C* (and some asm), *not* C++.
There /is/ no C++ support.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
