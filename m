Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265760AbRFXNsj>; Sun, 24 Jun 2001 09:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265761AbRFXNs3>; Sun, 24 Jun 2001 09:48:29 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:11273 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265760AbRFXNsK>;
	Sun, 24 Jun 2001 09:48:10 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: ARM show_trace_task and show_task cleanup 
In-Reply-To: Your message of "Sun, 24 Jun 2001 14:33:56 +0100."
             <20010624143356.J29636@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Jun 2001 23:48:03 +1000
Message-ID: <21595.993390483@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001 14:33:56 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>The following patch adds ARM support for show_trace_task() and changes
>die() to display the instruction trace as ksymoops expects it (code
>line last).

Thanks.

>-#if defined(CONFIG_X86) || defined(CONFIG_SPARC64)
>+#if defined(CONFIG_X86) || defined(CONFIG_SPARC64) || defined(CONFIG_ARM)
> /* This is very useful, but only works on x86 and sparc64 right now */

<nitpick>Comment needs updating</nitpick>

