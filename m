Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264675AbTFENxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 09:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264676AbTFENxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 09:53:09 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31354 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264675AbTFENxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 09:53:08 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200306051406.h55E6Yp25484@devserv.devel.redhat.com>
Subject: Re: [PATCH 2.5.70] NatSemi Geode out-of-order store enables
To: miura@da-cha.org (Hiroshi Miura)
Date: Thu, 5 Jun 2003 10:06:34 -0400 (EDT)
Cc: davej@suse.de, alan@redhat.com (Alan Cox),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <87y90gzrbn.wl%miura@da-cha.org> from "Hiroshi Miura" at Meh 05, 2003 08:39:24 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Most geode specific code already merged, but it need
> a definition of CONFIG_OOSTORE to speedup geode.

The OOSTORE shouldnt be needed according to the natsemi info,
you can just drop the ifdef
