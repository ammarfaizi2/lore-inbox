Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUHCIrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUHCIrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 04:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUHCIrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 04:47:03 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:15892 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S265250AbUHCIq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 04:46:59 -0400
Date: Tue, 3 Aug 2004 08:46:55 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
cc: Corey Minyard <minyard@acm.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IPMI watchdog question
In-Reply-To: <200408021905.28112.arekm@pld-linux.org>
Message-Id: <Pine.LNX.4.58.0408030843280.7078@praktifix.dwd.de>
References: <Pine.LNX.4.58.0407280901330.31636@praktifix.dwd.de>
 <200408021829.18228.arekm@pld-linux.org> <410E710E.20004@acm.org>
 <200408021905.28112.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004, Arkadiusz Miskiewicz wrote:

> On Monday 02 of August 2004 18:51, Corey Minyard wrote:
> 
> > Your patch looks very good.  Could you add the test and set change,
> > too?  Then I think it is ready to go in.
> Added.
> 
> - support disabling watchdog by writting ,,V'' to device.
> - unify printk()
> - use atomic bit operations on ipmi_wdog_open
> 
> Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>
> 
Many thanks for the quick patch! I have tested it and everything works as
expected.

Holger
