Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbUFJXi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUFJXi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 19:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUFJXiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 19:38:25 -0400
Received: from main.gmane.org ([80.91.224.249]:57498 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263415AbUFJXiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 19:38:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lars <terraformers@gmx.net>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Fri, 11 Jun 2004 01:38:25 +0200
Message-ID: <caard3$qt6$1@sea.gmane.org>
References: <ca9jj9$dr$1@sea.gmane.org> <200406110035.48711.bzolnier@elka.pw.edu.pl> <caap8q$m51$1@sea.gmane.org> <200406110123.36981.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e7ff0c.dip.t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aha! just learned something new :)
looks good to me.


thanks again for your time,
lars


>> its my understanding that
>> 0x9F01FF01 enables c1 and fix
>> 0x0F01FF01 disables c1, enables fix
>> 0x0F0FFF01 disables c1 and fix
>>
>> am i right ?
> 
> Yes but doing & should always give the right result:
> 0x0F0FFF01 & 0x9F01FF01 -> 0x0F01FF01
> (disabled -> disabled + fix)
> 0x9F0FFF01 & 0x9F01FF01 -> 0x9F01FF01
> (enabled -> enabled + fix)
> ...


