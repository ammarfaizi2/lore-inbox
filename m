Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUFJXDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUFJXDE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 19:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUFJXDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 19:03:04 -0400
Received: from main.gmane.org ([80.91.224.249]:62361 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263228AbUFJXBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 19:01:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lars <terraformers@gmx.net>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Fri, 11 Jun 2004 01:01:59 +0200
Message-ID: <caap8q$m51$1@sea.gmane.org>
References: <ca9jj9$dr$1@sea.gmane.org> <200406102356.07920.bzolnier@elka.pw.edu.pl> <caamob$gb0$1@sea.gmane.org> <200406110035.48711.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e7ff0c.dip.t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> On Friday 11 of June 2004 00:19, Lars wrote:
>> just learned that
>> setpci -H1 -s 0:0.0 6C.L=0x9F01FF01
>> enables C1 *and* the 80ns stability fix.
>>
>> looks like i have to stick with my ugly little workaround for a while
> 
> "ugly"?
just kiddin' ;)

> 
> We can probably change kernel fixup to always do & 0x9F01FF01
> but adding "force C1HD" kernel options sounds insane.
i guess that always applying 0x9F01FF01 will force c1 for all users
to *on* again, because the 9F value triggers this.
its my understanding that
0x9F01FF01 enables c1 and fix
0x0F01FF01 disables c1, enables fix
0x0F0FFF01 disables c1 and fix

am i right ?


best,
lars


