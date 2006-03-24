Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423208AbWCXG7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423208AbWCXG7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423206AbWCXG7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:59:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13228 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423205AbWCXG7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:59:06 -0500
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector v3
From: Arjan van de Ven <arjan@infradead.org>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Matt Helsley <matthltc@us.ibm.com>
In-Reply-To: <4423673C.7000008@gmail.com>
References: <4423673C.7000008@gmail.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 07:59:01 +0100
Message-Id: <1143183541.2882.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It is also never redundant functionality of audit subsystem, if enable 
> audit option, audit subsystem will audit all the syscalls, so it adds 
> big overhead for the whole system, 

this is not true

> but Filesystem Event Connector just
>  concerns those operations related to the filesystem, so it has little
>  overhead, moreover, audit subsystem is a complicated function block, 
> it not only sends audit results to netlink interface, but also send 
> them to klog or syslog, so it will add big overhead. you can look File
>  Event Connector as subset of audit subsystem, but File Event Connector
>  is a very very lightweight subsystem.

then make the syslog part optional.. if it's not already!


