Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282793AbRLGI3q>; Fri, 7 Dec 2001 03:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282814AbRLGI3g>; Fri, 7 Dec 2001 03:29:36 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:61200 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282793AbRLGI3a>;
	Fri, 7 Dec 2001 03:29:30 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: Your message of "Thu, 06 Dec 2001 21:10:11 -0800."
             <Pine.LNX.4.33.0112062109400.7866-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Dec 2001 19:29:18 +1100
Message-ID: <26499.1007713758@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 21:10:11 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>
>On Fri, 7 Dec 2001, Keith Owens wrote:
>>
>> Linus, the time has come to convert the 2.5 kernel to kbuild 2.5.
>
>We're getting the block IO layer in shape first, the time has not come for
>_anything_ else before that.

That is what I said ....

2.5.1           Semi-stable kernel, after bio is working.
2.5.2-pre1      Add the kbuild 2.5 and CML2 code, still using
                Makefile-2.5, supporting both CML1 and CML2.
2.5.2-pre2      Remove kbuild 2.4 code, rename Makefile-2.5 to Makefile.
		Still supporting both CML1 and CML2.
2.5.2-pre3      Remove CML1 support.

Is that timetable acceptable?

