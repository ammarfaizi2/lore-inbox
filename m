Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWFZGba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWFZGba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWFZGb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:31:29 -0400
Received: from narn.hozed.org ([209.234.73.39]:8674 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S964827AbWFZGb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:31:29 -0400
Date: Mon, 26 Jun 2006 01:31:28 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: linux-kernel@vger.kernel.org
Subject: ppc32 with CONFIG_KEXEC broken
Message-ID: <20060626063128.GA3359@narn.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

various things like 'reserve_crashkernel' are referenced, but only
exist in arch/powerpc/kernel/machine_kexec_64.c.

( This is using the mercurial repository from
http://www.kernel.org/hg/linux-2.6/, which I believe tracks git )
