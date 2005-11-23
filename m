Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbVKWXMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbVKWXMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbVKWXMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:12:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030482AbVKWXL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:11:56 -0500
Date: Wed, 23 Nov 2005 15:09:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-Id: <20051123150905.6c7a952d.akpm@osdl.org>
In-Reply-To: <20051123223438.GY3963@stusta.de>
References: <20051123223438.GY3963@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> Currently, using an undeclared function gives a compile warning, but it 
> can lead to a nasty runtime error if the prototype of the function is 
> different from what gcc guessed.
> 
> With -Werror-implicit-function-declaration, we are getting an immediate 
> compile error instead.

Where "we" == "me".  This patch means I get to fix all the errors which I
encounter.  No fair.  This should be the last patch, not the first.
