Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbTANRB4>; Tue, 14 Jan 2003 12:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTANRB4>; Tue, 14 Jan 2003 12:01:56 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:4878 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264724AbTANRBt>; Tue, 14 Jan 2003 12:01:49 -0500
Message-ID: <3E243CA4.C78C7DF@linux-m68k.org>
Date: Tue, 14 Jan 2003 17:36:52 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module state and address in /proc/modules.
References: <20030114025452.563462C374@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rusty Russell wrote:

> +       /* Used by oprofile and other similar tools. */
> +       seq_printf(m, " 0x%p", mod->module_core);
> +

Q: How does ksymoops find out with this, how the sections are laid out?
Q: What happens if the module crashes during init?

bye, Roman

