Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVFQFhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVFQFhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 01:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVFQFhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 01:37:50 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:30866 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261913AbVFQFhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 01:37:19 -0400
Date: Fri, 17 Jun 2005 07:37:18 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: rth@twiddle.net
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: getxpid, getxuid, getxgid
Message-ID: <20050617053718.GA16080@MAIL.13thfloor.at>
Mail-Followup-To: rth@twiddle.net,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I would like to know why alpha seems to be the only
arch which has assembler code for some syscalls
(like the sys_getx* calls)

is the alpha gcc compiler so bad that it can not 
handle the task of dereferencing the task struct?

is it some kind of legacy code, which should have
been removed a long time ago, but just wasn't?

or is there a special reason for doing so?

details: arch/alpha/kernel/entry.S

TIA,
Herbert

