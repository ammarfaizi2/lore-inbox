Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUHaMDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUHaMDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUHaMDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:03:31 -0400
Received: from the-village.bc.nu ([81.2.110.252]:3719 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268043AbUHaMD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:03:29 -0400
Subject: Re: microcode_ctl vs udev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1093906213l.24821l.1l@werewolf.able.es>
References: <1093906213l.24821l.1l@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093950085.32684.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 31 Aug 2004 12:01:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-30 at 23:50, J.A. Magallon wrote:
> It looks like udev creates /dev/microcode, but microcode_ctl looks for
> /dev/cpu/microcode.
> 
> Which is the right location ?

/dev/cpu/microcode according to the LANANA registration table

