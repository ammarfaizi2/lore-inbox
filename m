Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270891AbTGPOwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270892AbTGPOwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:52:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8650
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270891AbTGPOwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:52:34 -0400
Subject: Re: 2.6.0test1 - HPT374 kernel panic during booting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F12E53A.7050802@kmlinux.fjfi.cvut.cz>
References: <3F12E53A.7050802@kmlinux.fjfi.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058367892.6633.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jul 2003 16:04:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 18:15, Jindrich Makovicka wrote:
> with a segfault. 2.4.21 behaves the similar way - with a monolitic 
> kernel it does a kernel panic, the module loads but doesn't find any 
> disk. The driver from Highpoint website works fine.

Is the same true with the 2.4.22-pre5/6 driver. I fixed a couple of
problems along the way with the newest firmware tickling a bug in our
driver and someone else fixed an overuse of __init

