Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133097AbREFHpl>; Sun, 6 May 2001 03:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133099AbREFHpU>; Sun, 6 May 2001 03:45:20 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:6149 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S133097AbREFHpP>;
	Sun, 6 May 2001 03:45:15 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4 add suffix for uname -r 
In-Reply-To: Your message of "Sun, 06 May 2001 03:35:34 -0400."
             <Pine.LNX.4.33.0105060334390.1549-100000@asdf.capslock.lan> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 06 May 2001 17:45:06 +1000
Message-ID: <3437.989135106@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2001 03:35:34 -0400 (EDT), 
"Mike A. Harris" <mharris@opensourceadvocate.org> wrote:
>On Sun, 6 May 2001, Keith Owens wrote:
>>A frequent requirement is to rename vmlinuz-2.x.y to 2.x.y-old or
>>2.x.y.save to preserve a working kernel.
>
>I don't see how this patch is necessary when we have
>"EXTRAVERSION" available.  Change EXTRAVERSION in your kernel
>builds and it is totally a non issue.  No renaming of anything is
>necessary.

You already have a working kernel which you want to rename to use as a
backup version.  Changing EXTRAVERSION and recompiling builds a new
kernel and adds uncertainty about whether the kernel still works - did
you change anything else before recompiling?  Look at all the install
scripts that rename vmlinuz to vmlinuz-old.

