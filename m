Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313155AbSC1N2T>; Thu, 28 Mar 2002 08:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313151AbSC1N2A>; Thu, 28 Mar 2002 08:28:00 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:28900 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S313155AbSC1N1y>;
	Thu, 28 Mar 2002 08:27:54 -0500
Date: Thu, 28 Mar 2002 14:27:52 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Mark Atwood <mra@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to tell how much to expect from a fd
In-Reply-To: <m3663hjte0.fsf_-_@khem.blackfedora.com>
Message-ID: <Pine.LNX.4.44.0203281422120.2928-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 Mar 2002, Mark Atwood wrote:

> Does there exist a fcntl or some other way to tell how much data is
> "ready to be read" from a fd?

int val;
ioctl(fd, FIONREAD, &val);

See tcp(7).

Eric

