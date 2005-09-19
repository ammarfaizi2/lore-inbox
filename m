Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVISLu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVISLu7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 07:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVISLu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 07:50:59 -0400
Received: from [213.132.87.177] ([213.132.87.177]:8926 "EHLO gserver.ymgeo.ru")
	by vger.kernel.org with ESMTP id S932245AbVISLu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 07:50:58 -0400
From: Ustyugov Roman <dr_unique@ymg.ru>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools
Date: Mon, 19 Sep 2005 15:54:10 +0400
User-Agent: KMail/1.8
References: <200509191432.58736.dr_unique@ymg.ru> <2cd57c90050919043041ed5cc@mail.gmail.com>
In-Reply-To: <2cd57c90050919043041ed5cc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509191554.10767.dr_unique@ymg.ru>
X-OriginalArrivalTime: 19 Sep 2005 11:57:57.0439 (UTC) FILETIME=[601ACCF0:01C5BD11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/05 Coywolf Qi Hunt wrote:
> Yes, it's a bug. But it's a bad idea too to use well known kernel
> symbols as module names.

Sure. Please, add to module documentation:

To make unique name of module use command:

	touch `cat /dev/urandom | uuencode -m - | head -n 2 | tail -c10`.c

;-)

-- 
RomanU
