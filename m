Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131209AbRCWPJT>; Fri, 23 Mar 2001 10:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131226AbRCWPJJ>; Fri, 23 Mar 2001 10:09:09 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:17156 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131209AbRCWPI5>; Fri, 23 Mar 2001 10:08:57 -0500
Message-Id: <200103231508.f2NF83xY001147@pincoya.inf.utfsm.cl>
To: "Christian Bodmer" <cbinsec01@freesurf.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init 
In-Reply-To: Your message of "Thu, 22 Mar 2001 19:32:29 +0100."
             <3ABA534D.2392.3D7585@localhost> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Fri, 23 Mar 2001 11:08:03 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christian Bodmer" <cbinsec01@freesurf.ch> said:

> I can't say I understand the whole MM system, however the random killing
> of processes seems like a rather unfortunate solution to the problem. If
> someone has a spare minute, maybe they could explain to me why running
> out of free memory in kswapd results in a deadlock situation.

OOM is not "normal operations", it is a machine under very extreme stress,
and should *never* happen. To complicate (or even worse, slow down or
otherwise use up resources like memory) normal operations for "better
handling of OOM" is total nonsense.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
