Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031010AbWKUQ70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031010AbWKUQ70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031055AbWKUQ70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:59:26 -0500
Received: from lixom.net ([66.141.50.11]:38575 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1031010AbWKUQ7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:59:25 -0500
Date: Tue, 21 Nov 2006 10:58:43 -0600
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/22] powerpc: convert idle_loop to use
 hard_irq_disable()
Message-ID: <20061121105843.6b270283@pb15>
In-Reply-To: <200611211114.46305.arnd@arndb.de>
References: <20061120174454.067872000@arndb.de>
	<20061120180520.418063000@arndb.de>
	<1164070425.8073.40.camel@localhost.localdomain>
	<200611211114.46305.arnd@arndb.de>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 11:14:45 +0100 Arnd Bergmann <arnd@arndb.de> wrote:

> IIRC, all new CPUs are supposed to use the same mechanism based on the
> 0x100 vector.

It's only really affecting platforms without hypervisors though, which
aren't all that many (yet).

I don't have a problem dealing with it locally in my platform.


-Olof
