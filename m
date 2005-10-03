Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVJCQBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVJCQBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVJCQBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:01:38 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:58125 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932337AbVJCQBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:01:37 -0400
To: jonathan@jonmasters.org
CC: lkcl@lkcl.net, linux-kernel@vger.kernel.org
In-reply-to: <35fb2e590510030720t416dc210xc4e4eb11b3972822@mail.gmail.com>
	(message from Jon Masters on Mon, 3 Oct 2005 15:20:46 +0100)
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net> <35fb2e590510030720t416dc210xc4e4eb11b3972822@mail.gmail.com>
Message-Id: <E1EMSkK-00028o-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 03 Oct 2005 18:00:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But you /know/ this because you're a microprocessor designer as well
> as a contributor to the FUSE project?

AFAIK Luke never contributed to the FUSE project.  Hopefully that
answers your question.

FUSE and microkernels are sometimes mentioned together, but I believe
there's a very important philosophical difference:

FUSE was created to ease the development and use of a very _special_
group of filesystems.  It was never meant to replace (and never will)
the fantastically efficient and flexible internal filesystem
interfaces in Linux and other monolithic kernels.

On the other hand, the microkernel approach is to restrict _all_
filesystems to the more secure, but less efficient and less flexible
interface.  Which is stupid IMO.

Miklos
