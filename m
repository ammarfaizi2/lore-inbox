Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263052AbVCELJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbVCELJn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 06:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbVCELJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 06:09:43 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:26736 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263052AbVCELHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 06:07:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mkIsd4b0ePdpWQ4EGVXGfkLscGYIVdwnckdsE96Lb1mWehNRKhMqCcW1/focg7PJg/yazknfOEev+W+xfKf3x53jDC4KozaTliEvxta2IqW2Rur9VyN4wrC/lHHp/Z7VstDkociHMFL3doGEOMDIYEjbYfruS/f26rcWuM6AYs0=
Message-ID: <2cd57c900503050307443810aa@mail.gmail.com>
Date: Sat, 5 Mar 2005 19:07:53 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Alexey Dobriyan <adobriyan@mail.ru>
Subject: Re: [patch] remove the `.' in EXTRAVERSION usage
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, akpm@osdl.org
In-Reply-To: <200503051347.08860.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2cd57c90050305022211b94e86@mail.gmail.com>
	 <200503051347.08860.adobriyan@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2005 13:47:08 +0200, Alexey Dobriyan <adobriyan@mail.ru> wrote:
> On Saturday 05 March 2005 12:22, Coywolf Qi Hunt wrote:
> 
> > Since 2.6.9, there came along the LOCALVERSION for people to add local
> > version in make menuconfig which was EXTRAVERSION originally for imho.
> > Now EXTRAVERSION goes just as a kernel version number, it's reasonable
> > to remove the `.' in its usage.
> 
> > -KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
> > +KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL).$(EXTRAVERSION)$(LOCALVERSION)
> 
> You want 2.6.11.-mm2 or 2.6.11.mm2 ? :-)
> 
>         Alexey
> 

True. My fault, EXTRAVERSION isn't always present and isn't even
always a number.
Thanks all. 
.-)

-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
