Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVHCWWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVHCWWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVHCWWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 18:22:47 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:55838 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261200AbVHCWWq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 18:22:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=torvU/uJ2jEa6vKe1T+AqeBbHmgklj6hX206YDMWEoq+GiYgbMWWUsomLqfb+InwdHJOh1T4aQmf9ibNyCwSGxeJSBYQXVg9+iKKZGvDRQiEIw2Z13deAInoUClGvJ4734Zbll+2mTQy6/FBaNu/dqWAOEpSn3hK2EPj+M35mws=
Message-ID: <3afbacad050803152226016790@mail.gmail.com>
Date: Thu, 4 Aug 2005 00:22:46 +0200
From: Jim MacBaine <jmacbaine@gmail.com>
Reply-To: Jim MacBaine <jmacbaine@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
In-Reply-To: <200508040716.24346.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508031559.24704.kernel@kolivas.org>
	 <3afbacad05080312201d388f8e@mail.gmail.com>
	 <200508040716.24346.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/05, Con Kolivas <kernel@kolivas.org> wrote:

> What happens when you disable it at runtime before suspending?
> 
> echo 0 > /sys/devices/system/dyn_tick/dyn_tick0/enable

This has no effect. The system stalls at exactly the same point. The
last lines on my screen are:

...
Software Suspend Core.
Software Suspend Compression Driver loading.
Software Suspend Encryption Driver loading.
Software Suspend Swap Writer loading.
Software Suspend FileWriter loading.
dyn-tick: Maximum ticks to skip limited to 13
dyn-tick: Timer using dynamic tick
ACPI wakeup devices:
SBTN USB0 USB1 EHCI AC97 MC97 LAN0 FSD0
ACPI: (supports S0 S3 S4 S5)
Software Suspend 2.1.9.11: Swapwriter: Signature found.
Software Suspend 2.1.9.11: Suspending enabled.

Regards,
Jim
