Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135940AbRD0JpH>; Fri, 27 Apr 2001 05:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136001AbRD0Jo5>; Fri, 27 Apr 2001 05:44:57 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:43793 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135998AbRD0Jor>; Fri, 27 Apr 2001 05:44:47 -0400
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Cc: William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <200103031114.MAA13672@cave.bitwizard.nl>
From: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>
Date: 08 Mar 2001 14:05:25 +0100
In-Reply-To: R.E.Wolff@BitWizard.nl's message of "Sat, 3 Mar 2001 12:14:22 +0100 (MET)"
Message-ID: <87elw8v2ay.fsf@mose.informatik.uni-tuebingen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Crater Lake)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Rogier Wolff <R.E.Wolff@BitWizard.nl> writes:

     > William T Wilson wrote:
    >> On Fri, 2 Mar 2001 Matt_Domsch@Dell.com wrote:
    >> 
    >> > Linus has spoken, and 2.4.x now requires swap = 2x RAM.
    >> 
    >> I think I missed this.  What possible value does this have?
    >> (Not even Sun, the original purveyors of the 2x RAM rule, need
    >> this any more).

     > RAM is still about 100x more expensive than HD. So I always
     > recommend you use about 2% of the money you spent on RAM to pay
     > for the HD space to handle swap.

     > Actually the deal is: either use enough swap (about 2x RAM) or
     > use none at all.

I believe the 2xRAM rule comes from the OS's where ram was only buffer
for the swap. So with 1xRAM you had a running system with 1xRAM
memory, so nothing is gained by that much swap.

On Linux any swap adds to the memory pool, so 1xRAM would be
equivalent to 2xRAM with the old old OS's.

Generally I would say that you need so much swap that you mouse does
not stop when its used. That usually means so much swap as you can
read/write within 10-30 seconds when done continuous. If you need more
swap the system becomes unuseable and performance goes realy down.

But thats all just my liking. Some applications can use 10xRAM swap
and still not stop the mouse from working, some applications do that
with 100 MB swap. I would keep swap moderate (one 2GB partition should
be enough for any normal system) and use swapfiles in case more is
needed temporary.

MfG
        Goswin
