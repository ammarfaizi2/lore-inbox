Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317405AbSGZI76>; Fri, 26 Jul 2002 04:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSGZI76>; Fri, 26 Jul 2002 04:59:58 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:18425 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317405AbSGZI75>; Fri, 26 Jul 2002 04:59:57 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3D4078C7.4010304@linux.org> 
References: <3D4078C7.4010304@linux.org> 
To: John Weber <john.weber@linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux PCMCIA 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 10:03:10 +0100
Message-ID: <11261.1027674190@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


john.weber@linux.org said:
> I noticed on the kernel status doc that a revamp of kernel pcmcia is
> in  the works.  Can anyone elaborate?

The PCMCIA code makes me want to vomit. It wants printing out and ritually 
burning, while taking care not to inhale the fumes which might affect your 
brain.

> For example, does this mean that 16-bit PCMCIA cards will use hotplug?

That is the plan.

> Does this mean that 32-bit cards will stop requiring cardmgr to simply
>  bind devices to drivers (is it too much to ask that the driver know
> what  it drives :)? 

That is also the plan.

Unfortunately the plan is all we have at the moment, other than a few 
hundred lines of untested core device/driver registration code and untested 
CIS-parsing code. I threw that together hoping it would work like stone 
soup -- but it hasn't worked yet, so it's going to have to wait till I have 
more time to play.

--
dwmw2


