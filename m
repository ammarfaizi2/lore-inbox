Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSCRP6y>; Mon, 18 Mar 2002 10:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSCRP6n>; Mon, 18 Mar 2002 10:58:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1933 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286322AbSCRP6b>;
	Mon, 18 Mar 2002 10:58:31 -0500
Date: Mon, 18 Mar 2002 10:58:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: vda@port.imtp.ilyichevsk.odessa.ua,
        Felix Braun <Felix.Braun@mail.McGill.ca>, linux-kernel@vger.kernel.org
Subject: Re: devfs mounted twice in linux 2.4.19-pre3
In-Reply-To: <200203181536.g2IFabF18869@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0203181057050.14280-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Mar 2002, Richard Gooch wrote:

> No, I don't think that's the problem. I now also have two devfs
> entries in /proc/mounts with 2.4.19-pre3. My boot scripts don't mount
> devfs. I'm looking into the problem. It seems to have something to do
> with Al's changes to the boot sequence code.

It has and it will go away when the next series is merged.

