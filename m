Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWG0RN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWG0RN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWG0RN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:13:57 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:14232 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750925AbWG0RNz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:13:55 -0400
Subject: Re: [PATCH] kthread: drivers/base/firmware_class.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: ranty@debian.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, serue@us.ibm.com, haveblue@us.ibm.com
In-Reply-To: <20060726235902.GB9645@us.ibm.com>
References: <20060726235902.GB9645@us.ibm.com>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 19:12:44 +0200
Message-Id: <1154020364.9543.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sukadev,

> This patch replaces kernel_thread() call in drivers/base/firmware_class.c
> with kthread_create() since kernel_thread() is deprecated in drivers.

the patch looks good to me.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

> Signed-off-by: Sukadev Bhattiprolu (sukadev@us.ibm.com)
> CC: Cedric Le Goater <clg@fr.ibm.com>
> CC: Serge E. Hallyn <serue@us.ibm.com>
> CC: Dave Hansen <haveblue@us.ibm.com>
> CC: Manuel Estrada Sainz <ranty@debian.org>

http://www.infodrom.org/Debian/ranty.html

Regards

Marcel


