Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVK2CeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVK2CeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 21:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVK2CeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 21:34:05 -0500
Received: from ns.is.iscas.ac.cn ([159.226.5.73]:3333 "EHLO is.iscas.ac.cn")
	by vger.kernel.org with ESMTP id S932334AbVK2CeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 21:34:03 -0500
Date: Tue, 29 Nov 2005 10:58:35 +0800
Message-Id: <200511291058.AA5571022@is.iscas.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "sun xiaoshan" <sunxs@is.iscas.ac.cn>
Reply-To: <sunxs@is.iscas.ac.cn>
To: <linux-kernel@vger.kernel.org>
Subject: INTERACTIVE_SLEEP(p) can return a value bigger than MAX_SLEEP_AVG
X-Mailer: <IMail v8.10>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has this been noticed when the p->static_prio is 16 .. 19 ??I wonder why
this is allowed .
And in  recalc_task_prio() function ,
sleep_time > INTERACTIVE_SLEEP(p)
statement may be false always when p->static_prio is 16 .. 19 




________________________________________________________________
Sent via the WebMail system at is.iscas.ac.cn


 
                   
