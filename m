Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbRACHft>; Wed, 3 Jan 2001 02:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130316AbRACHfk>; Wed, 3 Jan 2001 02:35:40 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:12665 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129859AbRACHf3>; Wed, 3 Jan 2001 02:35:29 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.3.24 is available 
In-Reply-To: Your message of "Tue, 02 Jan 2001 19:12:49 BST."
             <20010102191249.A4299@emma1.emma.line.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jan 2001 18:04:55 +1100
Message-ID: <9779.978505495@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001 19:12:49 +0100, 
Matthias Andree <matthias.andree@stud.uni-dortmund.de> wrote:
>There's a problem. depmod should not try to do anything besides giving
>its version when --version is used, should it?

Historical accident.  I want to clean that up but it breaks existing
behaviour; somewhere, somebody is bound to rely on depmod -V updating
modules.dep at the same time.  modutils 2.5 will clean up a lot of
backwards compatibility crud, including this one.  But you will not see
modutils 2.5 until Linus rolls kernel 2.5 and we start the next
development cycle.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
