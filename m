Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVFUMpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVFUMpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFUMoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:44:02 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5028 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261299AbVFUMie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:38:34 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
References: <20050620235458.5b437274.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119357351.3325.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 13:35:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-06-21 at 07:54, Andrew Morton wrote:
> CONFIG_HZ for x86 and ia64: changes default HZ to 250, make HZ Kconfigurable.
>     Will merge (will switch default to 1000 Hz later if that seems necessary)

This has been in Fedora for a while. DaveJ can probably give you more
info. From own testing 100Hz is how far down you want to go to avoid
random clock slew on laptops and to see power improvements.


