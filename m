Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269154AbRGaBhQ>; Mon, 30 Jul 2001 21:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269151AbRGaBhF>; Mon, 30 Jul 2001 21:37:05 -0400
Received: from zok.sgi.com ([204.94.215.101]:29342 "EHLO zok.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S269149AbRGaBgv>;
	Mon, 30 Jul 2001 21:36:51 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Boris Pisarcik <boris@boris.localdomain>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in sound.o 
In-Reply-To: Your message of "Mon, 30 Jul 2001 20:29:13 -0400."
             <20010730202913.A6226@boris.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2001 11:36:47 +1000
Message-ID: <31799.996543407@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 20:29:13 -0400, 
Boris Pisarcik <boris@boris.localdomain> wrote:
>What seems strange to me are those warnings of symbol mischmatch (see
>appended files).

ksymoops bug, it does not relocate bss correctly.  Fixed in my tree, to
be released "soon".

