Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbQKFRZz>; Mon, 6 Nov 2000 12:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129869AbQKFRZp>; Mon, 6 Nov 2000 12:25:45 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:44275 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129867AbQKFRZl>;
	Mon, 6 Nov 2000 12:25:41 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <03da01c04816$8b178a30$650201c0@guidelet> 
In-Reply-To: <03da01c04816$8b178a30$650201c0@guidelet>  <200011061631.eA6GVkw07051@pincoya.inf.utfsm.cl> <6590.973530406@redhat.com> 
To: "Alon Ziv" <alonz@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 17:25:37 +0000
Message-ID: <8453.973531537@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alonz@usa.net said:
> The best solution to the sound driver issue, IMHO, is still entirely
> userspace--- just no-one has written it yet. What we should do: 1.
> Before auto-unload of the driver, run a small utility which will read
> mixer settings
>    and save them somewhere 2. When auto-loading the driver, use driver
> arguments which are initialized from the
>    settings saved above

That could work, although it may be better to make it more generic and 
capable of handling any form of data. 

Any form of persistent storage would do - and if it can be handled entirely
in userspace, all the better. I merely pointed out that Keith's 
inter_module_xxx could provide this quite cleanly. Others disputed that it 
was required at all.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
