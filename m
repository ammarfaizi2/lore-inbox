Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTEPAHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 20:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264322AbTEPAHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 20:07:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43176 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264235AbTEPAHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 20:07:20 -0400
Date: Thu, 15 May 2003 17:19:38 -0700 (PDT)
Message-Id: <20030515.171938.27803073.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305152020.h4FKKfGi014696@locutus.cmf.nrl.navy.mil>
References: <20030515.131021.104054490.davem@redhat.com>
	<200305152020.h4FKKfGi014696@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chas, please update your tree now before sending me more
patches.  There were a few rejects when I tried to apply
this one (which I fixed up myself), for example in the
net/atm/lec.c diffs there is a conflict because the C99
struct initializer transformation had been done already by
a previous patch you've sent me recently.

If we want to continue to process patches at such a high rate
as we do now, you really need to keep your tree sync'd properly
when generating diffs.
