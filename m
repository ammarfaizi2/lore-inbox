Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293648AbSCKIu3>; Mon, 11 Mar 2002 03:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293650AbSCKIuS>; Mon, 11 Mar 2002 03:50:18 -0500
Received: from as2-1-6.lh.m.bonet.se ([194.236.130.162]:61701 "EHLO alpha")
	by vger.kernel.org with ESMTP id <S293648AbSCKIuM>;
	Mon, 11 Mar 2002 03:50:12 -0500
Date: Mon, 11 Mar 2002 09:50:06 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-ID: <20020311085006.GA1402@oskar>
In-Reply-To: <20020310210802.GA1695@oskar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020310210802.GA1695@oskar>
User-Agent: Mutt/1.3.27i
From: Oskar Liljeblad <oskar@osk.mine.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, March 10, 2002 at 22:02, usel wrote:
> The code snipper demonstrates what I consider a bug in the
> dnotify facilities in the kernel. After a fork, all registered
> notifications are lost in the process where they originally
> where registered (the parent process). [..]

FWIW, as long as you keep the child alive after fork the
notifications are not lost. Also the same effect when you
keep the parent(s) alive and decide to receive notification
in the newly created process instead.

Oskar Liljeblad (oskar@osk.mine.nu)
