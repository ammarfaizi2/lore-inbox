Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272401AbTGaMfE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 08:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272896AbTGaMfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 08:35:04 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:48907 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S272401AbTGaMfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 08:35:01 -0400
Message-Id: <200307311224.h6VCOMj19676@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Ren <l.s.r@web.de>
Subject: Re: [PATCH] Inline vfat_strnicmp()
Date: Thu, 31 Jul 2003 15:33:49 +0300
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20030727172150.15f8df7f.l.s.r@web.de> <87wue4udxl.fsf@devron.myhome.or.jp>
In-Reply-To: <87wue4udxl.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 July 2003 19:33, OGAWA Hirofumi wrote:
> Ren <l.s.r@web.de> writes:
> 
> > the function vfat_strnicmp() has just one callsite. Inlining it
> > actually shrinks vfat.o slightly.
> 
> Thanks. I'll submit this patch to Linus.

Just to deinline it in some months?

Come on, automatically inlining static functions with
just one callsite is a compiler's job. Don't do it.
--
vda
