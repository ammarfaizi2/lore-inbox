Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269077AbTGJIDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 04:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbTGJIBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 04:01:13 -0400
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:53123
	"EHLO www.piet.net") by vger.kernel.org with ESMTP id S269038AbTGJIBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 04:01:06 -0400
Subject: Re: 2.5.74-mm3 - module-init-tools: necessary to replace root
	copies?
From: Piet Delaney <piet@www.piet.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030710001853.5a3597b7.akpm@osdl.org>
References: <20030708223548.791247f5.akpm@osdl.org>
	<200307091106.00781.schlicht@uni-mannheim.de>
	<20030709021849.31eb3aec.akpm@osdl.org>
	<1057815890.22772.19.camel@www.piet.net>
	<20030710060841.GQ15452@holomorphy.com>
	<20030710071035.GR15452@holomorphy.com> 
	<20030710001853.5a3597b7.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Jul 2003 01:15:46 -0700
Message-Id: <1057824946.15253.30.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I followed your suggestion of installing the module-init-tools
to get around the "make modules_install" problem. I modified
the kernel Makefile to point to /usr/local:

	#DEPMOD         = /sbin/depmod
	DEPMOD          = /usr/local/sbin/depmod

I expect it's likely necessary to copy the /usr/local
copies over the / copies so that they are available to
the boot code; Perhaps not. 

I thought I check to see how you and/or others did
to for using the newer module-init-tools.

Also, do you think it's better to enable the use
frame pointer when using kgdb. In the past I thought
I had problems with modules due to my enabling the
frame pointer being used.

-piet

-- 
piet@www.piet.net

