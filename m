Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbUKVX5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbUKVX5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUKVXvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:51:36 -0500
Received: from mail.suse.de ([195.135.220.2]:58067 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262445AbUKVXn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:43:59 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
References: <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
	<Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
	<20041122113328.GQ10340@devserv.devel.redhat.com>
	<41A25D53.9050909@tmr.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm also against BODY-SURFING!!
Date: Tue, 23 Nov 2004 00:43:58 +0100
In-Reply-To: <41A25D53.9050909@tmr.com> (Bill Davidsen's message of "Mon, 22
 Nov 2004 16:42:43 -0500")
Message-ID: <je8y8t8n5t.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> Why can't you do dest=src? Assignment of struct to struct has been a part
> of C since earliest times.

It's not a struct, it's an array (of one element of struct type).  You
can't assign arrays.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
