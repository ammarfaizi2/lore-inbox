Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287933AbSANIkc>; Mon, 14 Jan 2002 03:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287984AbSANIkW>; Mon, 14 Jan 2002 03:40:22 -0500
Received: from mail.nmskb.cz ([213.151.92.16]:26809 "EHLO sam.nmskb.cz")
	by vger.kernel.org with ESMTP id <S287933AbSANIkR>;
	Mon, 14 Jan 2002 03:40:17 -0500
Message-ID: <3C429977.5000902@nmskb.cz>
Date: Mon, 14 Jan 2002 09:40:23 +0100
From: Marian Jancar <jancar@nmskb.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: cs, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.33.0201110142160.12174-100000@localhost.localdomain> <3C3F5C43.7060300@wanadoo.fr> <200201112150.g0BLoESr004177@svr3.applink.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2002 08:46:57.0963 (UTC) FILETIME=[068987B0:01C19CD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell wrote:
...

>
>But, given the above case, what happens when you have Sendmail on
>the first CPU and Squid is sharing the second CPU?  This is not optimal
>either, or am I missing something?
>

It will not happen (unless you have ligth speed disks and nics) in this 
scenario, both squid and sendmail are io-hogs, not cpu.


