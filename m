Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUHYXel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUHYXel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUHYXcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:32:42 -0400
Received: from sasami.anime.net ([207.109.251.120]:55185 "EHLO
	sasami.anime.net") by vger.kernel.org with ESMTP id S266242AbUHYXcB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:32:01 -0400
X-Antispam-Origin-Id: c4dc35da7d5d290438c6d6bdb17308d1
Date: Wed, 25 Aug 2004 16:31:50 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bizarre 2.6.8.1 /sys permissions
In-Reply-To: <20040825221814.GA20283@redhat.com>
Message-ID: <Pine.LNX.4.44.0408251630380.17580-100000@sasami.anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Message not sent from an IPv4 address, not delayed by milter-greylist-1.3.8 (sasami.anime.net [0.0.0.0]); Wed, 25 Aug 2004 16:31:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > $ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
>  > cat: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: Permission denied
> Reading this file causes reads from hardware on some cpufreq drivers.
> This can be a slow operation, so a user could degrade system performance
> for everyone else by repeatedly cat'ing it.

any reason why cpuinfo_cur_freq cant read cpu_khz ?

or rather, is there any reason why cpuinfo_cur_freq and /proc/cpuinfo 
should legitimately differ?

-Dan

