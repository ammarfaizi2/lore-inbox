Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWANQLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWANQLi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWANQLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:11:38 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17083 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751199AbWANQLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:11:37 -0500
Subject: Re: [2.6 patch] Fix PDC202XX_FORCE kconfig selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, "Andrey J. Melnikoff" <temnota@kmv.ru>
In-Reply-To: <20060114152119.GN29663@stusta.de>
References: <20060114152119.GN29663@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Jan 2006 16:13:03 +0000
Message-Id: <1137255183.20915.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-01-14 at 16:21 +0100, Adrian Bunk wrote:
> Split PDC202XX_FORCE selection into two independ option and allow user
> select it only for specific driver.

Seems pointless. We should always grab the raid cards. The option itself
is a mistake

Alan

