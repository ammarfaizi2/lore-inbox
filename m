Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVKCAhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVKCAhD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVKCAhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:37:02 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:14532 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030222AbVKCAhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:37:01 -0500
Date: Thu, 3 Nov 2005 01:36:51 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jean-Christian de Rivaz <jc@eclis.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: NTP broken with 2.6.14
In-Reply-To: <4369464B.6040707@eclis.ch>
Message-ID: <Pine.LNX.4.61.0511030134580.1387@scrub.home>
References: <4369464B.6040707@eclis.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 3 Nov 2005, Jean-Christian de Rivaz wrote:

> From the /var/log/ntpstats/peerstats history, the offset start growing
> exactly at the same time I rebooted with the new 2.6.14 kernel. The ntpd
> is the from the Debian Sarge version "ntpd 4.2.0a@1:4.2.0a+stable-2-r
> Fri Aug 26 10:30:12 UTC 2005 (1)".

Could you post a few lines from loopstats from before and after the 
upgrade? Do you have adjtimex installed? If yes, what's in 
/etc/default/adjtimex?

bye, Roman
