Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUAOBjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbUAOBhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:37:41 -0500
Received: from dp.samba.org ([66.70.73.150]:24199 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264547AbUAOBh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:37:26 -0500
Date: Thu, 15 Jan 2004 10:22:31 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: martin f krafft <madduck@madduck.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe failed: digest_null
Message-Id: <20040115102231.37a84ed0.rusty@rustcorp.com.au>
In-Reply-To: <20040113215355.GA3882@piper.madduck.net>
References: <20040113215355.GA3882@piper.madduck.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 22:53:55 +0100
martin f krafft <madduck@madduck.net> wrote:

> I am seeing many messages like
> 
>   kernel: request_module: failed /sbin/modprobe -- digest_null. error = 256
> 
> in my logs. What's the nature of these?

Upgrade module-init-tools to 0.9.14 or one of the 3.0 -pres.

Old "modprobe -q" fails when presented with a module it has never heard of.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
