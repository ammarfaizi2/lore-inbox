Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTEPDCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 23:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTEPDCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 23:02:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25770 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264342AbTEPDCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 23:02:13 -0400
Date: Thu, 15 May 2003 20:14:27 -0700 (PDT)
Message-Id: <20030515.201427.82121061.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] allow atm to be loaded as a module 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305160304.h4G34wGi016365@locutus.cmf.nrl.navy.mil>
References: <20030515.164732.15245120.davem@redhat.com>
	<200305160304.h4G34wGi016365@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Thu, 15 May 2003 23:04:58 -0400
   
   actually i see very  few protocol families check the return code
   from sock_register() --  should i ignore the return code as well?
   
That is a hard error, please don't do that.  Patches welcome
for protocols not checking this (but they must be correct :-).
