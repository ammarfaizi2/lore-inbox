Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTJRFXE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 01:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTJRFXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 01:23:03 -0400
Received: from holomorphy.com ([66.224.33.161]:49802 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261384AbTJRFXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 01:23:02 -0400
Date: Fri, 17 Oct 2003 22:26:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8: broken  /fs/proc/array.c  compilation
Message-ID: <20031018052609.GH25291@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>,
	linux-kernel@vger.kernel.org
References: <XFMail.20031018011826.f.duncan.m.haldane@worldnet.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20031018011826.f.duncan.m.haldane@worldnet.att.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 01:18:26AM -0400, Duncan Haldane wrote:
> fs/proc/array.c: In function `proc_pid_stat':
> fs/proc/array.c:398: Unrecognizable insn:
> (insn/i 1332 1672 1666 (parallel[
>             (set (reg:SI 0 eax)
>                 (asm_operands ("") ("=a") 0[
>                         (reg:DI 1 edx)
>                     ]

Compiler bogon, not kernel.


-- wli
