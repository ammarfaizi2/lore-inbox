Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUEVWbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUEVWbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 18:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUEVWbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 18:31:12 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:41088 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S261932AbUEVWbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 18:31:11 -0400
Message-Id: <200405222230.i4MMUwt29709@pincoya.inf.utfsm.cl>
To: Vadim Lobanov <vadim@cs.washington.edu>
cc: linux-kernel@vger.kernel.org, vonbrand@inf.utfsm.cl
Subject: Re: modprobe_path & hotplug_path 
In-reply-to: Your message of "Sat, 22 May 2004 15:05:28 MST."
             <20040522150054.R26485-100000@attu1.cs.washington.edu> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sat, 22 May 2004 18:30:58 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov <vadim@cs.washington.edu> said:
> Currently modprobe_path and hotplug_path are declared as "char ...[256]", 
> though it seems to me (unless I've missed something), that they only ever 
> hold "/sbin/modprobe" and "/sbin/hotplug", respectively. Any reason why we 
> couldn't simply declare them "char ...[]", and let them be sized 
> appropriately?

They can be modified by writing into appropiate /proc files.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
