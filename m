Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbTD0IJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 04:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTD0IJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 04:09:34 -0400
Received: from [12.47.58.68] ([12.47.58.68]:63108 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263845AbTD0IJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 04:09:34 -0400
Date: Sun, 27 Apr 2003 01:21:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oop in 2.5.68-mm2 apply_alternatives
Message-Id: <20030427012149.285bbde9.akpm@digeo.com>
In-Reply-To: <200304271013.47047.schlicht@uni-mannheim.de>
References: <200304271013.47047.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2003 08:21:41.0171 (UTC) FILETIME=[07C87030:01C30C96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> I get following (hand copied) Oops at init when booting 2.5.68-mm2.

You'll need to delete the `__init' qualifier from the definition
of arch/i386/kernel/setup.c:apply_alternatives()
