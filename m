Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVIGUOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVIGUOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVIGUOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:14:10 -0400
Received: from smtp.istop.com ([66.11.167.126]:15269 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751300AbVIGUOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:14:09 -0400
From: Daniel Phillips <phillips@istop.com>
To: jan.kiszka@googlemail.com
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Wed, 7 Sep 2005 16:17:24 -0400
User-Agent: KMail/1.8
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <58d0dbf10509071054175e82ff@mail.gmail.com> <200509071552.27543.phillips@istop.com>
In-Reply-To: <200509071552.27543.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509071617.24181.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 September 2005 15:52, Daniel Phillips wrote:
Ah, there's another issue: an interrupt can come in when esp is on the ndis 
stack and above THREAD_SIZE, so do_IRQ will not find thread_info.  Sorry,
this one is nasty.

Regards,

Daniel
