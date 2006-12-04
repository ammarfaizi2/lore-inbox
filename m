Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935993AbWLDLWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935993AbWLDLWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 06:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935997AbWLDLWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 06:22:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54175 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935993AbWLDLWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 06:22:10 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061202121742.GN11084@stusta.de> 
References: <20061202121742.GN11084@stusta.de>  <20061128020246.47e481eb.akpm@osdl.org> 
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>,
       dhowells@redhat.com
Subject: Re: [-mm patch] arch/frv/kernel/futex.c must #include <linux/uaccess.h> 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Dec 2006 11:20:57 +0000
Message-ID: <27018.1165231257@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> This patch fixes the following compile error with 
> -Werror-implicit-function-declaration
> (without -Werror-implicit-function-declaration it's a link error):

Looks reasonable.

Acked-By: David Howells <dhowells@redhat.com>
