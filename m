Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUGFM4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUGFM4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 08:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUGFM4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 08:56:35 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:5053 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263831AbUGFM4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 08:56:33 -0400
Message-Id: <200407061256.i66CuNnX003040@eeyore.valparaiso.cl>
To: "surfing t" <surf17@lycos.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Points to fs architecture 
In-Reply-To: Message from "surfing t" <surf17@lycos.com> 
   of "Mon, 05 Jul 2004 16:38:58 EST." <20040705213858.2002086AE1@ws7-1.us4.outblaze.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 06 Jul 2004 08:56:23 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I want to create a utility that "hooks" into the the filesystem. What I
> want to do is to be able to review all file system read/write/seek
> requests, most of the time without affecting file system operation (ie
> after review the request is passed on to the entity that would have
> received it had my utility not been installed, however some of the
> requests my driver should handle itself.

Prelink something that handles read/write to your application(s). No kernel
stuff involved at all. Better yet, this in completely independent of the
underlying filesystem.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
