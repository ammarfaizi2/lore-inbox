Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUJYITN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUJYITN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUJYITN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:19:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:49061 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261680AbUJYHf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:35:57 -0400
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce top(1) CPU usage by an order of magnitude
References: <200410251020.01932.vda@port.imtp.ilyichevsk.odessa.ua.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 25 Oct 2004 09:35:48 +0200
In-Reply-To: <200410251020.01932.vda@port.imtp.ilyichevsk.odessa.ua.suse.lists.linux.kernel>
Message-ID: <p73654z8d2j.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> Patch is not mine, Paulo Marques <pmarques@grupopie.com>
> wrote it.

The bug is in your top. It shouldn't read /proc/*/wchan
by default unless the user switches on WCHAN display.
Just disable that and it will be even faster. My top
doesn't read it at all, you probably got some buggy
version.

Also btw we normally let people submit their patches themselves.

-Andi

