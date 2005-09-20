Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVITHU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVITHU6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVITHU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:20:57 -0400
Received: from [213.132.87.177] ([213.132.87.177]:29347 "EHLO gserver.ymgeo.ru")
	by vger.kernel.org with ESMTP id S932758AbVITHU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:20:57 -0400
From: Ustyugov Roman <dr_unique@ymg.ru>
To: thayumk@gmail.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools
Date: Tue, 20 Sep 2005 11:24:35 +0400
User-Agent: KMail/1.8
References: <200509191432.58736.dr_unique@ymg.ru> <3b8510d8050920000560aeb39e@mail.gmail.com> <3b8510d805092000116c6a9c33@mail.gmail.com>
In-Reply-To: <3b8510d805092000116c6a9c33@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509201124.35942.dr_unique@ymg.ru>
X-OriginalArrivalTime: 20 Sep 2005 07:28:17.0541 (UTC) FILETIME=[DE8C0B50:01C5BDB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thayumanavar Sachithanantham wrote:
> > buf_printf(b, " .name = __stringify(KBUILD_MODNAME),\n");
>
> $(modname))),-DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname))))
>

In my case I've already had these lines at files you're specified.
But situation is unchanged. Module name is wrong :(
Any ideas?

-- 
RomanU
