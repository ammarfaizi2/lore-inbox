Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVBQGS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVBQGS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 01:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVBQGS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 01:18:27 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:13019 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262237AbVBQGSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 01:18:06 -0500
Date: Thu, 17 Feb 2005 15:18:08 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] /proc/cpumem
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1108619891.5148.104.camel@terminator.in.ibm.com>
References: <20050216170224.4C66.ODA@valinux.co.jp> <1108619891.5148.104.camel@terminator.in.ibm.com>
Message-Id: <20050217151337.4C8A.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I thought efi related data structures are of type __initdata and will be gone after initilization. (efi.c)

oops. certainly.
and, devmem_is_allowed does same mistake :-)
(I don't know who made it.)

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

