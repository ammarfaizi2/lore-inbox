Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSGLQUT>; Fri, 12 Jul 2002 12:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSGLQUS>; Fri, 12 Jul 2002 12:20:18 -0400
Received: from jalon.able.es ([212.97.163.2]:24305 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316623AbSGLQTr>;
	Fri, 12 Jul 2002 12:19:47 -0400
Date: Fri, 12 Jul 2002 18:22:29 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kirk Reiser <kirk@braille.uwo.ca>, linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
Message-ID: <20020712162229.GC2348@werewolf.able.es>
References: <E17T1a9-00037I-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E17T1a9-00037I-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 12, 2002 at 16:39:41 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.12 Alan Cox wrote:
>> Are these functions which are supplied by the FPU?  I've looked
>> through the fpu emulation headers and exp() is the only one I can find
>
>You can't use FPU operations in the x86 kernel.
>

Are you to worried about precission ? Can't you just do your sin() etc.
in fixed point ? (and move all your fpdata to fixed point, of course)

Or perhaps you could use some kind of DCT ?

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam3, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
