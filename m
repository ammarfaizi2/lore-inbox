Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262994AbVCKAki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbVCKAki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbVCKAkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:40:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:62881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262994AbVCKAkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 19:40:09 -0500
Date: Thu, 10 Mar 2005 16:39:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, elenstev@mesatop.com, mauriciolin@gmail.com
Subject: Re: oom with 2.6.11
Message-Id: <20050310163956.0a5ff1d7.akpm@osdl.org>
In-Reply-To: <423063DB.40905@g-house.de>
References: <422DC2F1.7020802@g-house.de>
	<3f250c710503090518526d8b90@mail.gmail.com>
	<3f250c7105030905415cab5192@mail.gmail.com>
	<422F016A.2090107@g-house.de>
	<423063DB.40905@g-house.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> wrote:
>
> i was going to compile 2.6.11-rc5-bk4, to sort out the "bad" kernel.
> compiling went fine. ok, finished some email, ok, suddenly my swap was
> used up again, and no memory left - uh oh! OOM again, with 2.6.11-rc5-bk2!

Well if you ran out of swap then yes, the oom-killer will visit you.

Why did you run out of swapspace?
