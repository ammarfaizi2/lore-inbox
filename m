Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUITDbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUITDbA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 23:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUITDbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 23:31:00 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63930 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265909AbUITDa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 23:30:59 -0400
Message-Id: <200409200010.i8K0AMte031651@localhost.localdomain>
To: plt@taylorassociate.com
cc: linux-kernel@vger.kernel.org
In-Reply-To: Message from plt@taylorassociate.com 
   of "Sun, 19 Sep 2004 05:29:28 MST." <1095596968.414d7ba88efc1@webmail.taylorassociate.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Sun, 19 Sep 2004 20:10:22 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plt@taylorassociate.com said:

> Question: Are you guys going to work on please cleaning up some of the
> errors in the code so we can get please get a more clean compile?

First of all, nobody here _ows_you anything. If you want it fixed, fix it
and send in a patch.

> drivers/mtd/nftlmount.c:44: warning: unused variable `oob'

Sometimes this is due to variables used for _other_ architectures (or
configurations). You have to chek it is really _never_ used before axing
it.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
