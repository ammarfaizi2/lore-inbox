Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbULROSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbULROSy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 09:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbULROSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 09:18:54 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:10789 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261156AbULROSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 09:18:51 -0500
Date: Sat, 18 Dec 2004 15:19:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: selva kumar <mailnselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New System call & Kernel compilation
Message-ID: <20041218141935.GA15970@mars.ravnborg.org>
Mail-Followup-To: selva kumar <mailnselva@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20041217102631.43898.qmail@web52106.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217102631.43898.qmail@web52106.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 02:26:31AM -0800, selva kumar wrote:
> selva:
>   After adding a new system call, should we have to
> recompile the whole kernel? can anyone help me
> regarding this?

You do not need to do a 'make clean'. Simply executing make will suffer 
since kbuild has track of all dependencies.

Assuming 2.6 kernel!

	Sam
