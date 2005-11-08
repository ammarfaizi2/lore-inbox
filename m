Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbVKHXHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVKHXHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbVKHXHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:07:44 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:56000 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030393AbVKHXHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:07:43 -0500
Subject: Re: Highpoint IDE types
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <43712830.90805@tmr.com>
References: <1131471483.25192.76.camel@localhost.localdomain>
	 <pan.2005.11.08.19.02.09.190896@sci.fi>
	 <1131480140.25192.98.camel@localhost.localdomain>  <43712830.90805@tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 23:38:30 +0000
Message-Id: <1131493110.25192.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-08 at 17:35 -0500, Bill Davidsen wrote:
> May we assume that this information was gathered in the interest of 
> something beyond pedantic curiousity? Will this simplify the driver 
> code, improve performance or reliability, etc?

Something like that

I've been collecting the data to get the libata driver right, and in
doing so even with the partial data I had came across some chunks of
data that are wrong in the ide/pci driver.

Its not made easier by the fact hpt seem to have taken down their own
drivers for older (now "unsupported" I suspect) chips.

The frequency and chip id data is needed to correctly tune the PLLs and
to identify the right base frequency for timing.

