Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWJIAAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWJIAAo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 20:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWJIAAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 20:00:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51940 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932134AbWJIAAn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 20:00:43 -0400
Date: Mon, 9 Oct 2006 01:00:41 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SPARC64 2.6.19-rc1 (git cb1055...) non-SMP build failure
Message-ID: <20061009000041.GI29920@ftp.linux.org.uk>
References: <200610082031.k98KV99S008302@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610082031.k98KV99S008302@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 04:31:09PM -0400, Horst H. von Brand wrote:
> I'm getting:
> 
>   CC      arch/sparc64/kernel/time.o
> arch/sparc64/kernel/time.c: In function 'timer_interrupt':
> arch/sparc64/kernel/time.c:463: error: too many arguments to function 'profile_tick'

Fix merged today
