Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131227AbQKVERI>; Tue, 21 Nov 2000 23:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132277AbQKVEQ7>; Tue, 21 Nov 2000 23:16:59 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:58472 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131125AbQKVEQv>; Tue, 21 Nov 2000 23:16:51 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: modutils 2.3.20 not backward compatible 
In-Reply-To: Your message of "Tue, 21 Nov 2000 20:17:47 PDT."
             <3A1B3ADB.17200DF6@timpanogas.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Nov 2000 14:46:38 +1100
Message-ID: <5038.974864798@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000 20:17:47 -0700, 
"Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:
>Was there a reason we removed the -i and -m options from newer modutils
>and broke backwards caompatibility?  I'm re-writing our module build
>scripts for the installer, and I discovered after upgrading to 2.3.20,
>that all the build scripts (about 10MB worth) are now busted and I have
>been spending most of this evening rewriting them so they work again.   

-i and -m have never been in the base code.  -i in depmod is a Redhat
add on, only in their distribution.  I have no idea what -m does, apart
from -m in insmod which is supported.  Blame the distributors.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
