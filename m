Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287303AbSBKGu2>; Mon, 11 Feb 2002 01:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSBKGuS>; Mon, 11 Feb 2002 01:50:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287303AbSBKGuN>;
	Mon, 11 Feb 2002 01:50:13 -0500
Message-ID: <3C676959.9F401A7B@zip.com.au>
Date: Sun, 10 Feb 2002 22:48:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: weber@nyc.rr.com, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 Compile Error
In-Reply-To: <3C6764E6.DB1E8F8D@zip.com.au>,
		<3C6750CD.46575DAA@mandrakesoft.com>
		<3C675E6B.4010605@nyc.rr.com>
		<3C6764E6.DB1E8F8D@zip.com.au> <20020210.223329.35676006.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Sun, 10 Feb 2002 22:29:58 -0800
> 
>    John Weber wrote:
>    > I don't know what the problem is, but un-inlining this function isn't
>    > correcting it.
> 
>    Try this:
> 
> Not sufficient, you have to also add a dummy "struct task_struct;"
> declaration before the thread_saved_pc extern.

It's already there, line 425?

-
