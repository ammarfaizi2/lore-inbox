Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292031AbSBOAt1>; Thu, 14 Feb 2002 19:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292017AbSBOAtR>; Thu, 14 Feb 2002 19:49:17 -0500
Received: from jalon.able.es ([212.97.163.2]:8408 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S292031AbSBOAtE>;
	Thu, 14 Feb 2002 19:49:04 -0500
Date: Fri, 15 Feb 2002 01:48:55 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ccroswhite@get2chip.com, linux-kernel@vger.kernel.org
Subject: Re: Problems with VM
Message-ID: <20020215014855.A14226@werewolf.able.es>
In-Reply-To: <3C6C53C0.E7562704@get2chip.com> <E16bWX6-0001hc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E16bWX6-0001hc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on vie, feb 15, 2002 at 01:47:24 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020215 Alan Cox wrote:
>> as 'normal' ran.  Consequently, I will have a machine that has 5M
>> 'normal' RAM, 800M 'cache' RAM and the reset coming out of swap space.
>> I need this 'cache' RAM placed back into the available RAM pool to be
>> used by applications.  Is there a patch/kernel configuration that I can
>> change this behavior?
>
>2.4.18-rc1 should fix the worst of that. The rmap patches in 2.4.18-ac
>definitely fix it
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

Or oyu can try the next patch from Andrea Arcangeli for the vm, still
to include in mainline. I have adapted it to apply cleanly on plain
2.4.18-rc1:

http://giga.cps.unizar.es/~magallon/linux/2.4.18-rc1-slb1/00-vm-24.gz



-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-rc1-slb1 #1 SMP Thu Feb 14 01:04:12 CET 2002 i686
