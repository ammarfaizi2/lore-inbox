Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWGRDIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWGRDIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 23:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWGRDIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 23:08:54 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:62302 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932068AbWGRDIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 23:08:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q1yb+gUNsnLGn8/o4Wt+h4SO/n6s01uCYqPC1hJdqJcSliaQiLhJn+lMdwCrLK6c/a+MfYnms1DzG8QKFruBaU9Ce8aDrJLb8ctd9ZN3EJTby5SYmcsqNh6K0vtdgoKLLG+F1c18NFxKCPh2gAL2MgLCoUWD4d02hkORQWKoGjc=
Message-ID: <4745278c0607172008x3343f397l22e4bec1b297fd0f@mail.gmail.com>
Date: Mon, 17 Jul 2006 23:08:53 -0400
From: "Vishal Patil" <vishpat@gmail.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Generic B-tree implementation
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <200607180258.k6I2wEFm012293@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <vishpat@gmail.com>
	 <4745278c0607171902pc218a9dn9c63dd6670ac7249@mail.gmail.com>
	 <200607180258.k6I2wEFm012293@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed, however if I am not mistaken B-trees are useful even for
virtual memory implementation, for example HP-UX uses B-trees for
managing virtual memory pages.

Also I did not get the statement
"Build infrastructure (== library) without clear users won't go very
far on LKML"

- Vishal


On 7/17/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Vishal Patil <vishpat@gmail.com> wrote:
> > I am attaching source files containing a very generic implementation
> > of B-trees in C. The implementation corresponds to in memory B-Tree
> > data structure. The B-tree library consists of two files, btree.h and
> > btree.c. I am also attaching a sample program main.c which should
> > hopefully make the use of the library clear.
>
> B-trees are useful mainly when you can get a bunch of pointers in one
> swoop, i.e., by reading nodes from disk.
>
> > I would be happy to receive inputs from the community for changes
> > (enchancements) to the library. All the more I would like to help
> > someone with a project which would take advantage of the B-Tree
> > implementation.
>
> Build infrastructure (== library) without clear users won't go very far on
> LKML.
> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
>


-- 
Motivation will almost always beat mere talent.
