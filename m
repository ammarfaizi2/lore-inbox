Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWH3JkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWH3JkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 05:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWH3JkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 05:40:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49568 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750791AbWH3JkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 05:40:04 -0400
Subject: Re: 2.6.18-rc5 - HPT302 wierdness
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Stoffel <john@stoffel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <17652.55275.556545.19616@smtp.charter.net>
References: <17652.55275.556545.19616@smtp.charter.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Aug 2006 11:01:44 +0100
Message-Id: <1156932104.6271.138.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-29 am 20:12 -0400, ysgrifennodd John Stoffel:
> The drives are identical, and bought at the same time, yet on bootup
> of 2.6.18-rc5, they show up with different values for CHS and for Max
> Request Size.

One is using LBA48 the other is not. Looks like you have two very
different firmwares

