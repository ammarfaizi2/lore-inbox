Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265822AbSKFQ5q>; Wed, 6 Nov 2002 11:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265823AbSKFQ5p>; Wed, 6 Nov 2002 11:57:45 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:48885 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265822AbSKFQ5p>; Wed, 6 Nov 2002 11:57:45 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <m3n0omk97i.fsf@lugabout.jhcloos.org> 
References: <m3n0omk97i.fsf@lugabout.jhcloos.org> 
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: 2.5 bk, input driver and dell i8100 nib+pad 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 17:04:21 +0000
Message-ID: <11033.1036602261@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cloos@jhcloos.com said:
> Trying out 2.5, I've got only a partially working mouse.  The usb
> mouse is fully functional, as are both sets of buttons on the
> notebook.  The mouse pad works, but the nib is ignored.

> Of course, I only ever use the nib and only noticed that the pad was
> working by accident.

> I seem to recall a similar post some time back, but cannot find it in
> my archives.   

http://lists.insecure.org/lists/linux-kernel/2002/Oct/7774.html

I've since been playing with the docs for the SuperIO chip but I'm not 
convinced we can actually talk to all four PS/2 ports individually unless 
we reflash the 8051 firmware on it, which I don't really want to play with.

--
dwmw2


