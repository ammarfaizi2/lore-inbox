Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWAAMMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWAAMMK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 07:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWAAMMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 07:12:10 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:6683 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751337AbWAAMMJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 07:12:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mjnvL4f0ocdkMBWXX44nciRwZFPZNDZ2M3oPfchbHozlJfiIpd6XfH7xO2ufLeLn768NvH8HkTa591eM6l0G4EVuxOL2bmtey9lyqw8phPjs6zxkKfqcgGyb1LKtqNJPs8tombw5JBwpLAgXoxFNYV/hj6LtwdsRpsjXybjjh4s=
Message-ID: <5a2cf1f60601010412r3ec10855s5ad6ed8e0a6f2ef1@mail.gmail.com>
Date: Sun, 1 Jan 2006 13:12:08 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Cc: Bradley Reed <bradreed1@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1136114772.17830.20.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051231202933.4f48acab@galactus.example.org>
	 <1136106861.17830.6.camel@laptopd505.fenrus.org>
	 <20060101115121.034e6bb7@galactus.example.org>
	 <1136114772.17830.20.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> >
> > DO YOU REALLY PREFER USERS NOT REPORT BUGS?

[...]

> So getting back to your question:
> I would say that I think it's generally better that bugs that cannot be
> reproduced on an untainted kernel are not reported on lkml, but reported
> to the vendor of the tainting module instead, simply because it's very
> likely that it'll waste precious debug time.

Although I like the idea of making the vendors of binary modules
really aware of the costs they introduce with regard to debug issues
on tainted system, if I was them, the first thing I would say is
"contact the vendor of the part of the system that changed", i.e. the
kernel.

J
