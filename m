Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317469AbSGaA14>; Tue, 30 Jul 2002 20:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSGaA14>; Tue, 30 Jul 2002 20:27:56 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:18 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317469AbSGaA1z>; Tue, 30 Jul 2002 20:27:55 -0400
Date: Wed, 31 Jul 2002 02:31:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <200207302341.g6UNfDF11136@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0207310149450.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 30 Jul 2002, Richard Gooch wrote:

> > As far as I can see it's still broken wrt to module unloading.
>
> No, it's not. Look more closely.

Are you sure it's save in devfs_open() too?
Even if it's save/fixed, it's still code duplication.

bye, Roman

