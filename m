Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbTDPRxD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbTDPRxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:53:03 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:39186 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264519AbTDPRxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:53:01 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Manfred Spraul <manfred@colorfullife.com>,
       Tomas Szepe <szepe@pinerecords.com>
Subject: Re: [PATCH] qdisc oops fix
Date: Wed, 16 Apr 2003 20:03:06 +0200
User-Agent: KMail/1.5.1
Cc: jamal <hadi@cyberus.ca>, Catalin BOIE <util@deuroconsult.ro>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
References: <20030415084706.O1131@shell.cyberus.ca> <20030416160606.GA32575@louise.pinerecords.com> <3E9D8A68.5050207@colorfullife.com>
In-Reply-To: <3E9D8A68.5050207@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304162003.06600.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 April 2003 18:52, Manfred Spraul wrote:

Hi Manfred,

> >The original backtrace as provided by Martin Volf does not contain
> >any weird addresses such as 0xd081ecc7 above:
> >http://marc.theaimsgroup.com/?l=linux-kernel&m=105013596721774&w=2
> Thanks.
> The bug was caused by sch_tree_lock() in htb_change_class().
> 2.4.21-pre7 contains a fix.
am I just blind or isn't there a fix in -pre7|current-BK?

ciao, Marc
