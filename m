Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274883AbTHPRBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274887AbTHPRBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 13:01:13 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:12425 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S274883AbTHPRBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 13:01:12 -0400
Subject: Re: scsi proc_info called unconditionally
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030816084409.GA8038@suse.de>
References: <20030816084409.GA8038@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061053254.10688.6.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 16 Aug 2003 18:00:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-08-16 at 09:44, Olaf Hering wrote:
> Why is ->proc_info() called when the function pointer is NULL?
> 
> (none):/# mount proc

Because proc_info is mandatory ?


