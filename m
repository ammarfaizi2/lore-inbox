Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWFVJot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWFVJot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWFVJot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:44:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42397 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932470AbWFVJos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:44:48 -0400
Subject: Re: + qla3xxx-NIC-driver.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: ron.mercer@qlogic.com, jeff@garzik.org, shemminger@osdl.org
In-Reply-To: <200606220455.k5M4tdjs018640@shell0.pdx.osdl.net>
References: <200606220455.k5M4tdjs018640@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 11:44:44 +0200
Message-Id: <1150969484.3120.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	struct semaphore ioctl_sem;

Hi,

my mail filters caught this patch introducing a new user of struct
semaphore... Is there any reason this is not a mutex? or... why is it
there at all since I seem to fail to find a user of it :-)

Greetings,
   Arjan van de Ven

