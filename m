Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbULUKE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbULUKE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 05:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbULUKE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 05:04:58 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:26959 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261633AbULUKEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 05:04:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mojR00kOVbgRzBm29rlzmIGbHeLpk1y+GiVdG2YHibWrHCvcvjGaF/tDSZElG9bOqL18r312EeJftEDUU/shbl1eXHGDwYLEhutk7YSMfx6wKC2AxSDdUT1ae74BSwIsfx5Vm9BspcPTd78QbXu5fRFIATN732bhLadYCTpD+Xg=
Message-ID: <72c6e379041221020463b1861b@mail.gmail.com>
Date: Tue, 21 Dec 2004 15:34:54 +0530
From: linux lover <linux.lover2004@gmail.com>
Reply-To: linux lover <linux.lover2004@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: loading modules at kernel startup
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <81b0412b041221013752802fc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <72c6e3790412210114650e05d1@mail.gmail.com>
	 <81b0412b041221013752802fc5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex,
               The kernel modules are netfilter modules that i wrote
and want to be loaded as soon as eth0 is up. Is there any way in
kernel to add my modules and get it loaded at startup?
              I actually added in .bashrc but modules are loaded with
every console i open but not once in system.
regards,
linux_lover


On Tue, 21 Dec 2004 10:37:32 +0100, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Tue, 21 Dec 2004 14:44:23 +0530, linux lover
> <linux.lover2004@gmail.com> wrote:
> > Hi all,
> > How to load own kernel modules just after eth0
> > interface is brought up?
> > I want to load kernel module as soon as networking part of kenrel
> > starts.
> 
> Look at udev and hotplug
> 
> > I dont want to loose any packets that travels on my linux
> > machine.
> 
> You'll always loose something: there will be a gap between activating
> of the network interface and running of your module (or sniffer, as it sounds).
>
