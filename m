Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSEaAgW>; Thu, 30 May 2002 20:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSEaAgV>; Thu, 30 May 2002 20:36:21 -0400
Received: from jalon.able.es ([212.97.163.2]:2760 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313087AbSEaAgV>;
	Thu, 30 May 2002 20:36:21 -0400
Date: Fri, 31 May 2002 02:36:15 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Dave Jones <davej@suse.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 cpu selection (first hack)
Message-ID: <20020531003615.GA13206@werewolf.able.es>
In-Reply-To: <20020530225015.GA1829@werewolf.able.es> <3CF6B3AD.6010106@mandrakesoft.com> <20020531014224.C9282@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.31 Dave Jones wrote:
>On Thu, May 30, 2002 at 07:20:13PM -0400, Jeff Garzik wrote:
>
> > wonder if making the CPU features selectable is useful? i.e. provide an 
> > actual config option for MMX memcpy, F00F bug, WP, etc. Normal (current) 
> > logic is to look at the cpu selected, and deduce these options.
>
>J.A's comment that most people compiling kernels shouldn't need to know
>what bugs their CPU has before they pick it is a good one imo[1]
>
>Also an explosion of CONFIG_ items where they can be sanely derived
>from others doesn't make much sense imo.
>

As I see it, kernel will only see a CONFIG_CPU_[3456]86 and a bunch
of CONFIG_X86-{foof,ppro-fence,mmx, etc}. The others will only be used
in CPUConfig.in to derive the visible ones.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP jue may 30 00:48:49 CEST 2002 i686
