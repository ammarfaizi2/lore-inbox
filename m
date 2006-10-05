Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWJEQDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWJEQDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWJEQDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:03:31 -0400
Received: from igw1.zrnko.cz ([81.31.45.161]:60832 "EHLO anubis.fi.muni.cz")
	by vger.kernel.org with ESMTP id S1751243AbWJEQDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:03:30 -0400
Date: Thu, 5 Oct 2006 18:05:18 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Machine reboot
Message-ID: <20061005160518.GM2923@mail.muni.cz>
References: <20061005105250.GI2923@mail.muni.cz> <aec7e5c30610050458x1fbe52bex851779d73c004350@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aec7e5c30610050458x1fbe52bex851779d73c004350@mail.gmail.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 08:58:22PM +0900, Magnus Damm wrote:
> A long shot, but switching to real mode does not work if the cpu is
> running in VMX root mode ie on hardware with Intel VT extensions
> enabled. So if you are using some kind of kernel virtualization module
> on rather new hardware, consider rmmod:ing the module before
> rebooting.
> 
> I'm about to post patches for kexec that fixes this problem, but I'm
> not sure about the current reboot status.

You are right, I'm using Intel Core 2 Duo processor with DP965LT board that is
capable of VT extensions. However, I'm using vanilla 2.6.18 kernel in X86_64,
no additional patches, nor XEN or VMWARE is running (even their modules are
not loaded). Moreover, SYSRQ-B (emergency reboot) works fine. System graceful
reboot does not work.

-- 
Luká¹ Hejtmánek
