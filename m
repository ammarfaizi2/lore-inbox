Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132889AbRAVQwA>; Mon, 22 Jan 2001 11:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132873AbRAVQvu>; Mon, 22 Jan 2001 11:51:50 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:14606 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132901AbRAVQve>;
	Mon, 22 Jan 2001 11:51:34 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
cc: David Luyer <david_luyer@pacific.net.au>, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: "Pass module parameters" to built-in drivers 
In-Reply-To: Your message of "Mon, 22 Jan 2001 16:56:38 BST."
             <20010122165638.E4979@almesberger.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Jan 2001 03:30:36 +1100
Message-ID: <5766.980181036@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001 16:56:38 +0100, 
Werner Almesberger <Werner.Almesberger@epfl.ch> wrote:
>Keith Owens wrote:
>> Inconsistent methods for setting the same parameter are bad.  I can and
>> will do this cleanly in 2.5.
>
>If your approach isn't overly intrusive (i.e. doesn't require changes
>to all files containing module parameters, or such), maybe you could
>make a patch for 2.4.x and wave it a little under Linus' nose. Maybe
>he likes the scent ;-)

It is part of my total Makefile rewrite for 2.5.  A clean
implementation of module parameters mapping to setup code requires the
mapping of a source file to the module it is linked into.  That
information is difficult to extract with the current Makefile system,
my rewrite makes it easy.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
