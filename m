Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSHFXcr>; Tue, 6 Aug 2002 19:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSHFXcr>; Tue, 6 Aug 2002 19:32:47 -0400
Received: from jalon.able.es ([212.97.163.2]:5338 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316588AbSHFXcq>;
	Tue, 6 Aug 2002 19:32:46 -0400
Date: Wed, 7 Aug 2002 01:34:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Marc-Christian Petersen <mcp@linux-systeme.de>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: AIO together with SMPtimers-A0 oops and freezing
Message-ID: <20020806233444.GE2733@werewolf.able.es>
References: <200208051920.29018.mcp@linux-systeme.de> <20020806160724.A19564@redhat.com> <20020806223550.GC2733@werewolf.able.es> <20020806191446.E19564@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020806191446.E19564@redhat.com>; from bcrl@redhat.com on Wed, Aug 07, 2002 at 01:14:46 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.08.07 Benjamin LaHaise wrote:
>On Wed, Aug 07, 2002 at 12:35:50AM +0200, J.A. Magallon wrote:
>> Hmm, I forgot to comment, but I apply smptimers on top of latest -aa, that
>> includes aio (is it different implementation?), and the kernel works fine.
>
>That would point to a merge error, or one of the changes that -aa made as 
>being relevant.  Someone has to extract the differences to track it down.
>

Latest thing I run is here:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-jam0/30-smptimers-A0.bz2

I applies on top of 00-aa0.bz2 (in the same location), which is a ported
version of latest -aa (-rc5-aa1) to 2.4.19-final.
But aio patches from -aa are accesible directly.


-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-jam0, Mandrake Linux 9.0 (Cooker) for i586
gcc (GCC) 3.2 (Mandrake Linux 9.0 3.2-0.2mdk)
