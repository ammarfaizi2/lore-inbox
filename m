Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbVLGAph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbVLGAph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 19:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbVLGAph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 19:45:37 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:16569 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932678AbVLGApg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 19:45:36 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume from disk)
Date: Wed, 7 Dec 2005 01:46:49 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, "Discuss x86-64" <discuss@x86-64.org>,
       Andi Kleen <ak@suse.de>
References: <20051204232153.258cd554.akpm@osdl.org>
In-Reply-To: <20051204232153.258cd554.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512070146.50221.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 5 December 2005 08:21, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/

}-- snip --{
> +x86_64-hpet-overflow.patch

This patch breaks resume from disk badly.  The box hangs solid as soon as interrupts
are reenabled during resume (right after the image has been read).  Unfortunately

> +x86_64-hpet-overflow-fix.patch

does not help.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
