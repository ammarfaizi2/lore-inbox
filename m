Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTKCRuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTKCRuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:50:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:51651 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262120AbTKCRuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:50:20 -0500
Date: Mon, 3 Nov 2003 09:50:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Konstantin Boldyshev <konst@linuxassembly.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com>
Subject: Re: minix fs corruption fix for 2.4
In-Reply-To: <20031103171925.GH7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0311030949040.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Nov 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Hmm...  I would rather check for regular|directory|symlink explicitly -
> note that FIFO and socket can have junk in i_data.

Fair enough, that's how sysvfs does it too.

Committed and pushed out.

Thanks Konstantin,

		Linus

