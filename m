Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316776AbSFUUGm>; Fri, 21 Jun 2002 16:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316777AbSFUUGl>; Fri, 21 Jun 2002 16:06:41 -0400
Received: from holomorphy.com ([66.224.33.161]:55747 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316776AbSFUUGl>;
	Fri, 21 Jun 2002 16:06:41 -0400
Date: Fri, 21 Jun 2002 13:06:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erik McKee <camhanaich99@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUGREPORT] kernel BUG in page_alloc.c:141!
Message-ID: <20020621200613.GB22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erik McKee <camhanaich99@yahoo.com>, linux-kernel@vger.kernel.org
References: <20020621191528.86025.qmail@web14202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020621191528.86025.qmail@web14202.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 12:15:28PM -0700, Erik McKee wrote:
> Booted 2.5.24, and it ran fine for sometime, before it dead(live) locked,
> causing a reboot.  Attempts to reboot were met with the following bug
> immediatly after calibrating delay loop, which equates out to an
> if(bad_range(buddy1,zone)) BUG; in __free_pages_ok:

This looks odd. Can you by any chance disassemble the parts before this?
Or better yet, reproduce it with a kernel compiled with -g and objdump
--source --disassemble vmlinux to get the disassembly of __free_pages_ok()?


Thanks,
Bill
