Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUHHVCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUHHVCr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 17:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUHHVCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 17:02:47 -0400
Received: from ppp-62-245-160-174.mnet-online.de ([62.245.160.174]:701 "EHLO
	killer.ninja.frodoid.org") by vger.kernel.org with ESMTP
	id S266293AbUHHVCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 17:02:40 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: no input with kernel 2.6.8-rc3-mm1 and X
References: <20040808112901.GA2958@luna.mooo.com>
From: Julien Oster <lkml-7994@mc.frodoid.org>
Organization: FRODOID.ORG
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Date: Sun, 08 Aug 2004 23:06:49 +0200
In-Reply-To: <20040808112901.GA2958@luna.mooo.com> (Micha Feigin's message
 of "Sun, 8 Aug 2004 14:29:02 +0300")
Message-ID: <87llgpjq52.fsf@killer.ninja.frodoid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin <michf@post.tau.ac.il> writes:

Hello,

> With kernel 2.6.8-rc3-mm1 I lose input completely the moment I start
> X. Keyboard is completely non-functional (include sysrq and num/ctrl
> lock) and the touchpad also doesn't seem to produce anything.

Before looking elsewhere, go into your BIOS setup and see if USB
mouse/keyboard legacy support is enabled. If it is, disable it.

That was often the cure for such problems for me.

Regards,
Julien
