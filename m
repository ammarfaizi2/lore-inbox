Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbTBPJIA>; Sun, 16 Feb 2003 04:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbTBPJH7>; Sun, 16 Feb 2003 04:07:59 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:65178 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266020AbTBPJH7>; Sun, 16 Feb 2003 04:07:59 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: John Weber <weber@nyc.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5 freezing after uncompressing linux
Date: Sun, 16 Feb 2003 10:17:42 +0100
User-Agent: KMail/1.5
References: <3E4EFD75.3000708@nyc.rr.com>
In-Reply-To: <3E4EFD75.3000708@nyc.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302161017.43944.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 February 2003 03:54, John Weber wrote:
> [1.] One line summary of the problem:
>
> [Linux 2.5] Freezing after Uncompressing Linux
>
> [2.] Full description of the problem/report:
>
> The kernel freezes immediately after "Uncompressing Linux... OK".
> No further messages are displayed.  I'm following wli's advice to
> add some printk's to check whether the system is even getting to
> startup_32(), but perhaps others have seen this problem.

Did it really freeze?  Can you see disk activity if you wait?  You may
simply not have turned on the console in your .config.  For example,
if you choose to compile the input subsystem as a module, then the
console automagically gets deselected!

Duncan.
