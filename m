Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbSJ1OW5>; Mon, 28 Oct 2002 09:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbSJ1OW5>; Mon, 28 Oct 2002 09:22:57 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:33760 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261228AbSJ1OW4>; Mon, 28 Oct 2002 09:22:56 -0500
Date: Mon, 28 Oct 2002 15:28:48 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andi Kleen <ak@suse.de>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, eggert@twinsun.com,
       linux-kernel@vger.kernel.org
Subject: Re: nanosecond file timestamp resolution in filesystems, GNU make, etc.
In-Reply-To: <20021028151533.D18441@wotan.suse.de>
Message-ID: <Pine.GSO.3.96.1021028152012.977D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Andi Kleen wrote:

> > So I propose: add a field to struct stat indicating the resolution of
> > the timestamps in it.  It can go on the end.
> 
> It's impossible. There is no space left in struct stat64
> And adding a new syscall just for that would be severe overkill.

 Well, possibly more stuff could benefit from new stat syscalls, like a
st_gen member for inode generations.  And as someone suggested, a version
number or a length could be specified by the calls this time to permit
less disturbing expansion in the future. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

