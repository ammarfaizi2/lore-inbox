Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbUAPC7R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 21:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAPC7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 21:59:17 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:44780 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265243AbUAPC7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 21:59:15 -0500
Message-ID: <4007537F.4070609@labs.fujitsu.com>
Date: Fri, 16 Jan 2004 11:59:11 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: filesystem bug?
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,

>Now, I can't tell from this whether it's a bash bug or an exit/signal
> bug, but it doesn't look like a filesystem problem for now. I'm going
> to try with a different shell to see if that helps.

I tried with /bin/zsh, and it seems you are right. The script
is working fine for about 2 hours.

So I will try to find out about EIO(inode corruption) problem next.

Thank you so much,

Yoshi

-- 
--
Yoshihiro Tsuchiya



