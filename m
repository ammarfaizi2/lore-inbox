Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317185AbSFWWzo>; Sun, 23 Jun 2002 18:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317187AbSFWWzo>; Sun, 23 Jun 2002 18:55:44 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:61725 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S317185AbSFWWzn>;
	Sun, 23 Jun 2002 18:55:43 -0400
Date: Sun, 23 Jun 2002 23:56:07 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [patch-2.5.24] microcode tidy-up + observation
In-Reply-To: <Pine.LNX.4.33.0206232120390.2650-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33.0206232354550.1089-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2002, Tigran Aivazian wrote:
> Observation: I noticed that all smp_num_cpus in the driver have been
> replaced by NR_CPUS. I assume this was done for the CPU hotplug support,
> although if smp_num_cpus reflects the "current" number of online cpus, I
> think, the driver would have worked as is and avoided wasting 64k-epsilon
> of memory.

Ok, I can see now that smp_num_cpus doesn't exist anymore on i386 but is
still there on other architectures.


