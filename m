Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbTHVAci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTHVAci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:32:38 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:6273 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S262957AbTHVAch
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:32:37 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Jeff Garzik <jgarzik@pobox.com>, Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Date: Thu, 21 Aug 2003 20:32:25 -0400
User-Agent: KMail/1.5
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <lRjc.6o4.3@gated-at.bofh.it> <20030820234810.GA24970@mail.jlokier.co.uk> <3F440C15.1050301@pobox.com>
In-Reply-To: <3F440C15.1050301@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308212032.25334.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 August 2003 20:02, Jeff Garzik wrote:

> > If userspace applications are ultimately compiled using Linux header
> > files, indirectly included via Glibc or some other libc, and the
> > kernel header files are GPL (version 2 only; not LGPL or any later
> > GPL), isn't distributing those binary applications a gross violation
> > of the GPL in some cases?
...
> One way or another (direct inclusion, or via glibc-kernheaders pkg) the
> headers today are GPL'd not LGPL'd... so I suppose it remains the realm
> of lawyers...
>
> IANAL,
>
> 	Jeff

So I take it one of the goals of cleaned and pressed kernel-ABI headers for 
2.7 would be to have them distributable under LGPL?  (Just trying to be 
explicit, here...)

Rob

