Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTE1E7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 00:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbTE1E7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 00:59:06 -0400
Received: from [213.171.53.133] ([213.171.53.133]:29445 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S264510AbTE1E7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 00:59:06 -0400
Date: Wed, 28 May 2003 08:14:18 +0400
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: eblade@blackmagik.dynup.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 and yahoo
Message-Id: <20030528081418.36a4b710.deepfire@ibe.miee.ru>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> however, with 2.5.70, when you close a window, it's process doesn't go 
> away.  It did not exhibit this in 2.5.69, and I'm not
> even anywhere near good enough to have the slightest idea where to begin 
> looking at it, but i'd figure i'd let someone know.

As a wild guess i`d suggest something signal related.

Like SIGCHLD not being delivered properly to the ymessenger process.
