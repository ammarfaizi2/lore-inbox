Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285034AbRLFHd5>; Thu, 6 Dec 2001 02:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285035AbRLFHdk>; Thu, 6 Dec 2001 02:33:40 -0500
Received: from zok.sgi.com ([204.94.215.101]:8585 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285034AbRLFHdc>;
	Thu, 6 Dec 2001 02:33:32 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: reese@isn.net (Garst R. Reese),
        linux-kernel@vger.kernel.org (linux-kernel)
Subject: Re: small feature request 
In-Reply-To: Your message of "Thu, 06 Dec 2001 01:58:55 CDT."
             <200112060658.fB66wtp351314@saturn.cs.uml.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Dec 2001 18:33:21 +1100
Message-ID: <12671.1007624001@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 01:58:55 -0500 (EST), 
"Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:
>Keith Owens writes:
>> "Garst R. Reese" <reese@isn.net> wrote:
>
>>> Would it possible to put a header on System.map indicating the kernel
>>> version?
>>> Sometimes my little brain forgets what kernel System.old is for.
>>
>> It is on my list for kbuild 2.5, once I start on the new design for
>
>Nooooo!!!!!
>
>Don't break stuff by adding headers. There is already a version
>in the file. It's in decimal, which sucks, but this will find it:
>
>grep ' Version_' System.map
>
>Adding a random 128-bit ID might be nice, as long as it's done
>in the same sort of way and is available via /proc. Something
>like this would do:  kern_128_id_UkZd1JLdOvAsALfFEL1UI

Strange, that is exactly what I was think of, adding symbols containing
information that tie the kernel, modules and System.map together more
reliably than the current "use some random System.map" method.

Do you want those exclamation marks back so they can be recycled?

