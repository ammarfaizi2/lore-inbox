Return-Path: <linux-kernel-owner+w=401wt.eu-S1750846AbXAITQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbXAITQa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbXAITQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:16:30 -0500
Received: from khc.piap.pl ([195.187.100.11]:54144 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbXAITQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:16:30 -0500
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH -MM] e1000: rewrite hardware initialization code
References: <45A3D29D.1000202@intel.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 09 Jan 2007 20:16:27 +0100
In-Reply-To: <45A3D29D.1000202@intel.com> (Auke Kok's message of "Tue, 09 Jan 2007 09:36:29 -0800")
Message-ID: <m3fyakau44.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok <auke-jan.h.kok@intel.com> writes:

>  drivers/net/e1000/Makefile            |   19
>  drivers/net/e1000/e1000.h             |   95
>  drivers/net/e1000/e1000_80003es2lan.c | 1330 +++++
>  drivers/net/e1000/e1000_80003es2lan.h |   89
>  drivers/net/e1000/e1000_82540.c       |  586 ++
>  drivers/net/e1000/e1000_82541.c       | 1164 ++++
>  drivers/net/e1000/e1000_82541.h       |   86
>  drivers/net/e1000/e1000_82542.c       |  466 ++
>  drivers/net/e1000/e1000_82543.c       | 1397 +++++
>  drivers/net/e1000/e1000_82543.h       |   45
>  drivers/net/e1000/e1000_82571.c       | 1132 ++++
>  drivers/net/e1000/e1000_82571.h       |   42

Perhaps the "e1000_" prefix could be dropped as redundant?
-- 
Krzysztof Halasa
