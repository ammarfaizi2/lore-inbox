Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSKYAYB>; Sun, 24 Nov 2002 19:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSKYAXA>; Sun, 24 Nov 2002 19:23:00 -0500
Received: from dp.samba.org ([66.70.73.150]:3514 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262130AbSKYAWv>;
	Sun, 24 Nov 2002 19:22:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't allocate memory when loading a module 2.5.48-bk 
In-reply-to: Your message of "Wed, 20 Nov 2002 00:43:03 -0800."
             <20021120084303.GB22936@kroah.com> 
Date: Mon, 25 Nov 2002 10:34:51 +1100
Message-Id: <20021125003005.6D43C2C111@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021120084303.GB22936@kroah.com> you write:
> With Linus's latest bk tree (plus some USB patches) I get the following
> error when trying to load the parport.o module:
> 
> # modprobe parport
> FATAL: Error inserting /lib/modules/2.5.48/kernel/parport.o: Cannot allocate 
memory
> 
> Any ideas?

No init section, my bad.  Should be fixed in 49.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
