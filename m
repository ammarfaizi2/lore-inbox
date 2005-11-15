Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVKOOw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVKOOw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVKOOw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:52:28 -0500
Received: from pc-4082.ethz.ch ([129.132.119.169]:56206 "EHLO
	komsys-pc-ruf.ethz.ch") by vger.kernel.org with ESMTP
	id S1751440AbVKOOw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:52:27 -0500
Date: Tue, 15 Nov 2005 15:52:26 +0100
From: Lukas Ruf <ruf@rawip.org>
To: Linux Kernel ml <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.15-rc1 crashed my file system for 2.6.14
Message-ID: <20051115145226.GA25699@tik.ee.ethz.ch>
Reply-To: Lukas Ruf <ruf@rawip.org>
Mail-Followup-To: Linux Kernel ml <linux-kernel@vger.kernel.org>
References: <20051115135526.GA24374@tik.ee.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115135526.GA24374@tik.ee.ethz.ch>
X-GPG: 0x81FCF845 -- visit http://www.ch.pgp.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lukas Ruf <ruf@rawip.org> [2005-11-15 14:55]:
>
[...]
>
> ---> how can I get back to 2.6.14 without loosing data
>

I rebooted with Knoppix.

Turned off ext3 journal on my root partition.

rebooted with Knoppix.

Run fsck.ext2 on my root partition.

Turned on ext3 journal on my root parition.

Rebooted with 2.6.14 without problems.

---> my problem is solved.  Thanks anyway.

wbr,
Lukas
-- 
Lukas Ruf   <http://www.lpr.ch> | Ad Personam
rbacs      <http://wiki.lpr.ch> | Restaurants, Bars and Clubs
Raw IP   <http://www.rawip.org> | Low Level Network Programming
Style  <http://email.rawip.org> | How to write emails
