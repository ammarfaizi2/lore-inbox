Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVBURdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVBURdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVBURdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:33:33 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:22469 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262048AbVBURdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:33:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aAB984kHpXDmeOmXwNtVbFFpuKUKYTCVmlGHVLa2CFXxK7CIMzJ8i3/LX3mEYB5W3S1/HN/tOTmFmcqL7CUsnhGU4+FDImg/AlN38I3X2BLCb2jVey1l47Id7VV+iy9ceoQLekSYVipg2KtXIpojy0lUG5GG+OQUeTbsGGrU+Qg=
Message-ID: <9e47339105022109333ae696dc@mail.gmail.com>
Date: Mon, 21 Feb 2005 12:33:28 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Problem: how to sequence reset of PCI hardware
Cc: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
In-Reply-To: <421A142A.1060302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105022023242e2fd9ce@mail.gmail.com>
	 <42199DD9.10807@pobox.com> <9e47339105022108527e3c679d@mail.gmail.com>
	 <421A142A.1060302@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 12:02:34 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> <shrug>  You do precisely what you just said:  run it before the
> device's probe function.
> 
> That typically means either initramfs addition or using 'install
> <module> command...' in /etc/modprobe.conf.

How does this work with a built-in framebuffer driver? Isn't it's
probe function going to get called before I can run something on
initramfs?


> 
>         Jeff
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
