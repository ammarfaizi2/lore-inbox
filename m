Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbTGILub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 07:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbTGILub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 07:50:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27568
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265975AbTGILu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 07:50:29 -0400
Subject: Re: [2.4][TRIVIAL] Use of uninitialized vars in
	arch/i386/kernel/process.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Disconnect <lkml@sigkill.net>
Cc: Riley@Williams.Name, davej@suse.de, hpa@zytor.com, trivial@rustcorp.com.au,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1057593701.4081.87.camel@slappy>
References: <1057593701.4081.87.camel@slappy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057752144.6255.46.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jul 2003 13:02:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-07 at 17:01, Disconnect wrote:
> If you don't pass reboot=, reboot_mode and reboot_thru_bios are used
> uninitialized and (in the case of reboot_mode) written directly to
> memory for the bios.

reboot_mode is static so defaults to zero.


