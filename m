Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWCJUsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWCJUsY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 15:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWCJUsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 15:48:23 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:9603 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932222AbWCJUsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 15:48:23 -0500
Date: Fri, 10 Mar 2006 12:52:59 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] security: fix capability bug
Message-ID: <20060310205259.GM27645@sorel.sous-sol.org>
References: <728201270603101150u20c20d86s851a2885de08e37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728201270603101150u20c20d86s851a2885de08e37@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ram Gupta (ram.gupta5@gmail.com) wrote:
> This patch fixes a bug of ptrace for PTRACE_TRACEME request. In this
> case the call is made by the child process & code needs to check the
> capabilty of the parent process to trace the child process but code
> incorrectly makes check for the child process. Please apply

I already submitted a fix for this (you were Cc' on the email).

thanks,
-chris
