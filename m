Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272402AbTGaG31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272415AbTGaG31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:29:27 -0400
Received: from quechua.inka.de ([193.197.184.2]:7641 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S272402AbTGaG31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:29:27 -0400
From: Bernd Eckenfels <ecki-lmk@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparse function pointer arguments now accept void pointers
In-Reply-To: <20030731052810.GA2853@osdl.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19i6wG-0000Um-00@calista.inka.de>
Date: Thu, 31 Jul 2003 08:29:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030731052810.GA2853@osdl.org> you wrote:
> This patch eliminates warnings of the form:
...
> -       if (t->type == SYM_PTR) {
> +       if (t->type == SYM_PTR || t->type == SYM_FN) {

unlikely

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
