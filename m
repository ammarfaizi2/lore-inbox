Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268331AbRGZQpk>; Thu, 26 Jul 2001 12:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268335AbRGZQpb>; Thu, 26 Jul 2001 12:45:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4367 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268331AbRGZQpN>; Thu, 26 Jul 2001 12:45:13 -0400
Subject: Re: ext3-2.4-0.9.4
To: riel@conectiva.com.br (Rik van Riel)
Date: Thu, 26 Jul 2001 17:46:18 +0100 (BST)
Cc: matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        hch@ns.caldera.de (Christoph Hellwig),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.33L.0107261311210.20326-100000@duckman.distro.conectiva> from "Rik van Riel" at Jul 26, 2001 01:13:34 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PoHC-00045g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> If you care about your email, probably you should either
> teach these people about standards like POSIX or SuS
> (and tell them to not rely on undefined behaviour) or
> switch to an MTA which isn't broken in various ways ;)

POSIX and SuS are actually not helpful here. They don't cover how to force
namespace to disk, only data and metadata for the file. So you can portably
stick your data onto disk, portably be sure its on disk, but not portably be
sure the directory entries are on disk.

Alan
