Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265228AbUGGRBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUGGRBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUGGRBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:01:41 -0400
Received: from cmsrelay01.mx.net ([165.212.11.110]:17877 "HELO
	cmsrelay01.mx.net") by vger.kernel.org with SMTP id S265226AbUGGRBi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:01:38 -0400
X-USANET-Auth: 165.212.8.2     AUTO bradtilley@usa.net uwdvg002.cms.usa.net
Date: Wed, 07 Jul 2004 13:01:35 -0400
From: Brad Tilley <bradtilley@usa.net>
To: Erik Mouw <erik@harddisk-recovery.com>, Brad Tilley <bradtilley@usa.net>
Subject: Re: Directory where modules are loacted in 2.6.7 build
CC: <linux-kernel@vger.kernel.org>
X-Mailer: USANET web-mailer (CM.0402.7.09)
Mime-Version: 1.0
Message-ID: <808iggRBj8512S02.1089219695@uwdvg002.cms.usa.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> wrote:

> You need to be root to install the modules in /lib/modules using "make
> modules_install", but everything else can be done as a normal user. If
> you want to have them installed somewhere else, you don't need to be
> root, btw, "make INSTALL_MOD_PATH=/tmp modules_install" will install
> the modules in /tmp/lib/modules .

Thank you. INSTALL_MOD_PATH is exactly what I needed.


