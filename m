Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUGFOuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUGFOuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 10:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUGFOuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 10:50:51 -0400
Received: from mx1.magmacom.com ([206.191.0.217]:18644 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S264012AbUGFOuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 10:50:50 -0400
Subject: Re: 2.6.7-mm6 -  USB problems
From: Jesse Stockall <stockall@magma.ca>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20040705023120.34f7772b.akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089125387.8352.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Jul 2004 10:49:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 05:31, Andrew Morton wrote:
> 
> - The USB update seems deadlocky.  I fixed one bug but it still causes my
>   ia64 test box to lock up on boot.  If it goes bad, please revert
>   usb-locking-fix.patch and then revert bk-usb.patch.  Retest and send a report
>   to linux-kernel and linux-usb-devel@lists.sourceforge.net.

On my test system with Via chipset, no ACPI everything (mouse and
storage device) works fine.

On my main system with Via chipset and ACPI, my USB mouse does not work
at all. 

Reverting usb-locking-fix.patch and bk-usb.patch makes it work again.

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

