Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVATLuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVATLuC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 06:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVATLuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 06:50:02 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:6181 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262121AbVATLt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 06:49:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UqzNaDhXqXR6+Hcjs+gPVLSBZ8AMxrwOgOkQtYJDgcW9gJS7nwAry4OE8VPoFfa6uTqSWu3FC2Fs3VtDuvgzSYPNaNgO8/vYRd9B3UJip9us6Do+Uo6kQ14tBB9oJuwqIv061VLk2e84n/rTYocZb7XiVoiDxZRXOQVk4yHu6xE=
Message-ID: <40f323d005012003492adaa8ff@mail.gmail.com>
Date: Thu, 20 Jan 2005 12:49:58 +0100
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc1-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40f323d0050120034013aa346e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050119213818.55b14bb0.akpm@osdl.org>
	 <40f323d0050120034013aa346e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005 12:40:40 +0100, Benoit Boissinot <bboissin@gmail.com> wrote:
> On Wed, 19 Jan 2005 21:38:18 -0800, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm2/
> >
> >
> > i386-cpu-hotplug-updated-for-mm.patch
> >  i386 CPU hotplug updated for -mm
> 
> With this patch, it doesn't build on UP with local APIC :
> 
> arch/i386/kernel/nmi.c: In function `check_nmi_watchdog':
> arch/i386/kernel/nmi.c:130: error: `cpu_callin_map' undeclared (first
> use in this function)
> 
> (cpu_callin_map is only declared on smp)


i found the fix in the other thread 
(2.6.11-rc1-mm2: CONFIG_SMP=n compile error)

sorry for the noise
