Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbREUSOv>; Mon, 21 May 2001 14:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262313AbREUSOm>; Mon, 21 May 2001 14:14:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30887 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262302AbREUSO3>;
	Mon, 21 May 2001 14:14:29 -0400
Date: Mon, 21 May 2001 14:14:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Abramo Bagnara <abramo@alsa-project.org>,
        Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <Pine.LNX.4.30.0105211239460.17263-100000@waste.org>
Message-ID: <Pine.GSO.4.21.0105211407281.12245-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 May 2001, Oliver Xymoron wrote:

> If you've got side channels that are of a packet nature (aka commands),
> then they can all happily coexist on one device. If you've got channels
> that are streams or intended for mmap, those ought to be different
> devices.

Since you've been refering to -9 - care to take a look at the contents of
uart(3)? Or lpt(3). Or draw(3), for that matter.

