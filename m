Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRAHSzA>; Mon, 8 Jan 2001 13:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRAHSyu>; Mon, 8 Jan 2001 13:54:50 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:48139 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S129706AbRAHSyo>;
	Mon, 8 Jan 2001 13:54:44 -0500
Date: Mon, 8 Jan 2001 19:54:25 +0100
From: Marc Lehmann <pcg@goof.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Stefan Traby <stefan@hello-penguin.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010108195425.A2472@cerebro.laendle>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Stefan Traby <stefan@hello-penguin.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010108192455.A1891@stefan.sime.com> <Pine.GSO.4.21.0101081332460.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0101081332460.4061-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 01:33:50PM -0500
X-Operating-System: Linux version 2.2.18 (root@cerebro) (gcc version pgcc-2.95.2.1 20001224 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 01:33:50PM -0500, Alexander Viro <viro@math.psu.edu> wrote:
> And prefix would be what? "/"? Besides, I said that you don't have
> read permissions on /foo, not search ones.

You do not need read permissions on /foo to make pathconf on it. This
makes sense: you are not reading the directory...

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
