Return-Path: <linux-kernel-owner+w=401wt.eu-S1762638AbWLKKsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762638AbWLKKsx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762645AbWLKKsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:48:53 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:46152 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762638AbWLKKsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:48:51 -0500
Date: Mon, 11 Dec 2006 11:48:57 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061211104857.GA16009@aepfle.de>
References: <200612110436_MC3-1-D49E-FE59@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200612110436_MC3-1-D49E-FE59@compuserve.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Chuck Ebbert wrote:

> Why not create a new initcall category for things that must run before
> early userspace?

Why do you want to continue with papering over the root cause?
Pick some janitor, let him write something that implements something
like make style dependencies for initcalls.
Then you can get rid of all that foo_initcall stuff.
It surely needs work to get all that done.
