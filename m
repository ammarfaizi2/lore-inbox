Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUEAJU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUEAJU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 05:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUEAJU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 05:20:27 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:34772 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262063AbUEAJU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 05:20:26 -0400
Date: Sat, 1 May 2004 11:19:18 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: Tim Hockin <thockin@hockin.org>, Michael Poole <mdpoole@troilus.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040501091918.GC29089@louise.pinerecords.com>
References: <20040427234136.GA17801@hockin.org> <Pine.LNX.4.44.0404280149480.15618-100000@hubble.stokkie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404280149480.15618-100000@hubble.stokkie.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr-28 2004, Wed, 01:59 +0200
Robert M. Stockmann <stock@stokkie.net> wrote:

> > > The needed header files, which need to be read by the gcc compiler, contain
> > > unnamed and annonymizes structures and unions. In the worst case scenario,
> > > only the name of used variables are given and no info about variable type or
> > > size are inside these headers files. gcc-2.95.3 fails to succesfully link these
> > 
> > Opaque types have been available FOREVER.
> 
> sure, but can one qualify that as Open Source?

Are you familiar with my friend "void *"?

-- 
Tomas Szepe <szepe@pinerecords.com>
