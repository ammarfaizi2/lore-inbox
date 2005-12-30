Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVL3IZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVL3IZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVL3IZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:25:08 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:44203 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751224AbVL3IZH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:25:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=md9ED6utTFuJ2aHnJG+/rTQuxf46K7aYnNqBPDqI72d5qFDOXlJdGfJxqKzg/2GLaNEhFXB9Rc7YnEYRfE88U5Y+ruF8hCPk6MdYqae13Y61LhnSpyQEG/lZvYjkcT0/+OqS8njUOT2YfxVOYx6k7Pn6gY+/8n+xpktjf56VlS0=
Message-ID: <9a8748490512300025y67cae1d8p8d41450c5a464abb@mail.gmail.com>
Date: Fri, 30 Dec 2005 09:25:06 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: Re: Howto set kernel makefile to use particular gcc
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B2239C2@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3AEC1E10243A314391FE9C01CD65429B2239C2@mail.esn.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Mukund JB. <mukundjb@esntechnologies.co.in> wrote:
>
> Dear Alessandro,
>
> Thanks for the reply.
> What does that the make CC=<path_to_your_gcc_3.3> do?
> Will it set my gcc default build configuration to gcc 3.3?
>
> I mean the general procedure is make bzImage; make modules....

That was the common way with 2.4.x kernels. Sure, you can still do
that, but with 2.6.x the recommended thing is to just do "make" (or in
your case "make CC=</path/to/gcc-3.3>") which will both build the
kernel and the modules.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
