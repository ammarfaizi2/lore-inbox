Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSEALyQ>; Wed, 1 May 2002 07:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311180AbSEALyP>; Wed, 1 May 2002 07:54:15 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:6406 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S311025AbSEALyP>; Wed, 1 May 2002 07:54:15 -0400
Date: Wed, 1 May 2002 13:54:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Gregoire Favre <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 compil error
In-Reply-To: <20020501113505.GA17077@ulima.unil.ch>
Message-ID: <Pine.LNX.4.21.0205011349100.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 1 May 2002, Gregoire Favre wrote:

> make oldconfig
> make dep bzImage modules
> 
> Isn't that supposed to be enough?

No, dependencies aren't automatically reloaded after "make dep", so the
bzImage step used the old dependencies.

bye, Roman


