Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270117AbTGUO0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270120AbTGUO0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:26:53 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:58515 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S270117AbTGUO0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:26:39 -0400
Message-Id: <200307211441.h6LEfQT02085@pincoya.inf.utfsm.cl>
To: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion for a new system call: convert file handle to a cookie for transfering file handles between processes. 
In-reply-to: Your message of "Mon, 21 Jul 2003 11:49:15 +0200."
             <4cace4bf68.4bf684cace@teleline.es> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Mon, 21 Jul 2003 10:41:25 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es> said:
> Although it is posible to use unix sockets, my proposal
> integrates better with shell scripts.

I fail to see why using sockets et al in shell scripts is that important.
You have full access to the API from Perl, for one; shell scripts are used
mostly as scaffolding for calling "normal" programs, so inventing something
to do what you want and call that from the shell is the way to go IMHO.
Only if there is absolutely no way to do it sanely outside the kernel, and
futhermore it is very important to do, should the kernel get involved
(sure, Linux is way the largest Unix installed base around today, but still
_far_ from the one that defines the standards in the area, which means a
Linux-only system call is a step forward and three back, so...)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
