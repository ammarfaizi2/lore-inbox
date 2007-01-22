Return-Path: <linux-kernel-owner+w=401wt.eu-S1751816AbXAVAfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXAVAfw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 19:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbXAVAfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 19:35:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33364 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbXAVAfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 19:35:51 -0500
Subject: Re: [PATCH] Undo some of the pseudo-security madness
From: Arjan van de Ven <arjan@infradead.org>
To: Samium Gromoff <_deepfire@feelingofgreen.ru>
Cc: linux-kernel@vger.kernel.org, David Wagner <daw@cs.berkeley.edu>
In-Reply-To: <87tzykuj49.wl@betelheise.deep.net>
References: <87y7nxvk65.wl@betelheise.deep.net>
	 <1169345764.3055.935.camel@laptopd505.fenrus.org>
	 <87tzykuj49.wl@betelheise.deep.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 22 Jan 2007 01:35:46 +0100
Message-Id: <1169426146.3055.1163.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the core of the problem are the cores which are customarily
> dumped by lisps during the environment generation (or modification) stage,
> and then mapped back, every time the environment is invoked.

> 
> at the current step of evolution, those core files are not relocatable
> in certain natively compiling lisp systems.

nor will they work if the sysadmin applies a security update and glibc
or another library changes one page in size. Or changes the stack rlimit
or .. or ..

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

