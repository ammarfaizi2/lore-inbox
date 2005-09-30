Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbVI3SNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVI3SNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVI3SNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:13:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19089 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932559AbVI3SNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:13:50 -0400
Message-Id: <200509301813.j8UIDXr5015488@laptop11.inf.utfsm.cl>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Subject: Re: [howto] Kernel hacker's guide to git, updated 
In-Reply-To: Message from Jeff Garzik <jgarzik@pobox.com> 
   of "Fri, 30 Sep 2005 07:15:41 -0400." <433D1E5D.20303@pobox.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 30 Sep 2005 14:13:33 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 30 Sep 2005 14:13:35 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
> Thanks for all the comments.  I just updated the KHGtG with the
> feedback I received.  Go to
> 
> 	http://linux.yyz.us/git-howto.html
> 
> and click reload.  Continued criticism^H^H^Hcomments welcome!

- To know the current branch, "git branch" is enough (the one '*'-ed)
- rsync(1) a repository is dangerous, it might catch it in the middle of
  a update and give you an incomplete/messed up copy. Repeat rsync until no
  change, perhaps?
- I understand "git checkout -f" blows away any local changes, no questions
  asked. Not very nice to suggest that to a newbie...

Thanks for the docu!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
