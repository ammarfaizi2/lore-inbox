Return-Path: <linux-kernel-owner+w=401wt.eu-S1752357AbWLSDmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbWLSDmg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 22:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbWLSDmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 22:42:36 -0500
Received: from mail.enter.net ([216.193.128.40]:15180 "EHLO mmail.enter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbWLSDmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 22:42:35 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Alexandre Oliva <aoliva@redhat.com>
Subject: Re: GPL only modules
Date: Mon, 18 Dec 2006 22:42:33 -0500
User-Agent: KMail/1.9.5
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Linus Torvalds <torvalds@osdl.org>,
       Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
References: <200612161927.13860.gallir@gmail.com> <86C272DA-23BA-4901-994D-6CABCC87A2DE@mac.com> <orlkl56lgi.fsf@redhat.com>
In-Reply-To: <orlkl56lgi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612182242.33759.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 14:41, Alexandre Oliva wrote:
> On Dec 17, 2006, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > On the other hand, certain projects like OpenAFS, while not license-
> > compatible, are certainly not derivative works.
>
> Certainly a big chunk of OpenAFS might not be, just like a big chunk
> of other non-GPL drivers for Linux.
>
> But what about the glue code?  Can that be defended as not a derived
> work, such that it doesn't have to be GPL?

That has never been an issue, really. Its what 99% of the binary drivers 
believe - hence the reason that there is the user-compiled component to all 
of them.

> If not, can the whole containing both the non-derivative work and the
> source code providing the glue without which the whole wouldn't
> fulfill its intended purpose be regarded as a mere aggregate, and thus
> not be subject to the requirement that the whole be released under the
> GPL?

The view that binary vendors take is "Linking does not create a derived 
work" - regardless of the fact that you cannot have a complete compiled 
program or module *WITHOUT* that linking. However I have a feeling that the 
lawyers in the employ of the companies that ship BLOB drivers say that all 
they need to do to comply with the GPL is to ship the glue-code in source 
form.

And I have to admit that this does seem to comply with the GPL - to the 
letter, if not the spirit.

DRH
