Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281216AbRKLCUJ>; Sun, 11 Nov 2001 21:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281217AbRKLCT7>; Sun, 11 Nov 2001 21:19:59 -0500
Received: from zok.SGI.COM ([204.94.215.101]:6622 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281216AbRKLCTr>;
	Sun, 11 Nov 2001 21:19:47 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC-ONT (on topic)] Modprobe enhancement (was Re: "Dance of the Trolls") 
In-Reply-To: Your message of "Sun, 11 Nov 2001 16:49:46 PDT."
             <004601c16b0b$8b04bb80$f5976dcf@nwfs> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Nov 2001 13:19:35 +1100
Message-ID: <32224.1005531575@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2001 16:49:46 -0700, 
"Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:
>Anton,
>
>This is a great suggestion.  You should ping Keith Owens (does he own
>modutils, I think so) and make it happen.  A much desireable change.
>----- Original Message -----
>From: "Anton Altaparmakov" <aia21@cus.cam.ac.uk>
>> I think we ought to do the same with closed source drivers. It's true
>> after all... The whole point of tainting the kernel is so we can just yell
>> at users to go and bug the vendor. So the modprobe executable could warn
>> the user "hey, you are loading a binary only module, it can break the
>> system, are you sure?". If the module is autoloaded we don't do jumping
>> through hoops asking questions so the systen runs smoothly.

Modutils 2.4.9 onwards gives a warning when loading tainted modules,
including a reason why the tainting occurred.  I will not accept
anything stronger than a warning, that is the Unix way(TM), give the
user enough rope to hang themselves.

