Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287924AbSABTfU>; Wed, 2 Jan 2002 14:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287923AbSABTfK>; Wed, 2 Jan 2002 14:35:10 -0500
Received: from hera.cwi.nl ([192.16.191.8]:24450 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S287919AbSABTe5>;
	Wed, 2 Jan 2002 14:34:57 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 2 Jan 2002 19:34:07 GMT
Message-Id: <UTC200201021934.TAA190744.aeb@cwi.nl>
To: jgarzik@mandrakesoft.com, torvalds@transmeta.com
Subject: Re: [PATCH] Re: NFS "dev_t" issues..
Cc: dalecki@evision.ag, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see lots of people sending patches for kdev_t.
In order to possibly avoid duplication of work,
I put my patch at ftp.kernel.org:
2.5.2pre6-kdev_t-diff (415841 bytes)

It has kminor and kmajor, but if that is not desired
a very simple edit on the patch will turn them into
minor and major.

(It is incomplete, but a good start.)

Andries
