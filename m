Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWIUJKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWIUJKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 05:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWIUJKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 05:10:01 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58753 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751060AbWIUJKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 05:10:00 -0400
Subject: Re: Request kernel 2.6.18 ..
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Duncan <ben@versaccounting.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4511DD6E.5090402@versaccounting.com>
References: <4511DD6E.5090402@versaccounting.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Sep 2006 10:34:15 +0100
Message-Id: <1158831256.11109.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-20 am 19:31 -0500, ysgrifennodd Ben Duncan:
> Report: 2.6.18 has solved a lot of issues with
> my 965 chipset Duo Core intel MB and has been
> extremely stable ...
> 
> Now, any idea on a timeline for driver for the Marvell IDE
> controller ?

Possibly never. Marvell don't currently seem to want to play. Now that
might be for several reasons, one of which is that its someone elses
chip rebadged. In that case someone has a chance of working out what it
copies (eg which bits change when you boot with or without a master or
slave on each channel is a good clue)

The current prognosis however is that you and/or other marvell users are
going to have to reverse-engineer the thing or just avoid boards using
that chip.

