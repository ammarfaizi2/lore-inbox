Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUEXXRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUEXXRY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUEXXRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:17:24 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:11019 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id S263736AbUEXXRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:17:20 -0400
Date: Tue, 25 May 2004 09:29:23 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modifying kernel so that non-root users have some root capabilities
In-Reply-To: <67B3A7DA6591BE439001F2736233351202B47E6F@xch-nw-28.nw.nos.boeing.com>
Message-ID: <Pine.LNX.4.05.10405250914190.6321-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004, Laughlin, Joseph V wrote:

> I've been tasked with modifying a 2.4 kernel so that a non-root user can
> do the following:
> 
> Dynamically change the priorities of processes (up and down)
> Lock processes in memory
> Can change process cpu affinity
> 
> Anyone got any ideas about how I could start doing this? 

Have you had a look at kernel capabilities?

E.g. CAP_SYS_NICE in linux/include/kernel/capability.h might be somewhat
interesting.

> (I'm new to kernel development, btw.)

No offence implied, but questions like this are better addressed in a
forum such as the kernelnewbies list, see:
http://www.kernelnewbies.org/mailinglist.php3

HTH,
Neale.

