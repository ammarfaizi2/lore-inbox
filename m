Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280692AbRKBN4h>; Fri, 2 Nov 2001 08:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280693AbRKBN41>; Fri, 2 Nov 2001 08:56:27 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:39432 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280692AbRKBN4R>;
	Fri, 2 Nov 2001 08:56:17 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: dalecki@evision.ag
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit. 
In-Reply-To: Your message of "Fri, 02 Nov 2001 13:39:29 BST."
             <3BE29401.157394A5@evision-ventures.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Nov 2001 00:55:04 +1100
Message-ID: <2211.1004709304@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Nov 2001 13:39:29 +0100, 
Martin Dalecki <dalecki@evision-ventures.com> wrote:
>Bull shit. Standard policy is currently to keep crude old
>interfaces until no end of time. Here are some examples:
>...
>/proc/ksyms - this is duplicating a system call (and making stuff easier
>for intrusors)

Anybody can issue syscall query_module.  Removing /proc/ksyms just
forces users to run an executable or Perl syscall().  You have not
improved security and you have made it harder to report and diagnose
problems.

