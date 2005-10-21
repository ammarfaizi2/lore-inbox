Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVJUNNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVJUNNe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVJUNNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:13:34 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:1407 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964914AbVJUNNd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:13:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c7emyYgqZUTmii3nyfRFN6nTZsMwaTkL+u2MYm2NkH4khebuOTBk7eLxx2D54J8GTNJG/+8WJY30+sSnUGuwhV+mRx8RBWC5gjvVXqSqnb9DsSXmZwDe0GSi2PFNkSA1vn+zlWp/lcAt1XH5WJpQZqNrUgluZCoDdzQTmjLob60=
Message-ID: <9a8748490510210613w233d4f59vd5b516f29832b919@mail.gmail.com>
Date: Fri, 21 Oct 2005 15:13:33 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Bluesmoke missing renames
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1129901843.26367.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1129901843.26367.46.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> As was noted on and off list a couple of places still had old naming
>

You forgot the one in the Makefile :-)

--- linux-2.6.14-rc4-mm1-orig/drivers/edac/Makefile     2005-10-17
12:00:36.000000000 +0200
+++ linux-2.6.14-rc4-mm1/drivers/edac/Makefile  2005-10-17
15:03:49.000000000 +0200
@@ -1,5 +1,5 @@
 #
-# Makefile for the Linux kernel bluesmoke drivers.
+# Makefile for the Linux kernel EDAC drivers.
 #
 # Copyright 02 Jul 2003, Linux Networx (http://lnxi.com)
 # This file may be distributed under the terms of the


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
