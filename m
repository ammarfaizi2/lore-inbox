Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264088AbUEXHog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbUEXHog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbUEXHog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:44:36 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:48791 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264088AbUEXHoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:44:34 -0400
Message-ID: <40B1A7DE.8080309@yahoo.com.au>
Date: Mon, 24 May 2004 17:44:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Phy Prabab <phyprabab@yahoo.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       jakob@unthought.net, linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
References: <20040524072107.63774.qmail@web90005.mail.scd.yahoo.com>
In-Reply-To: <20040524072107.63774.qmail@web90005.mail.scd.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phy Prabab wrote:
> For more information, I ran the same test on 2.4.21

...

Is hyperthreading enabled on 2.6 and 2.4? Can you send
a cat /proc/cpuinfo | grep processor for a 2.4 and a 2.6
kernel please?

If you have hyperthreading enabled, try 2.6.7-rc1 with
SMT (hyperthreading) scheduler support enabled in the
kernel config. It is in processor type and features menu.

