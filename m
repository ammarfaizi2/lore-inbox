Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288473AbSBRWPS>; Mon, 18 Feb 2002 17:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288174AbSBRWO6>; Mon, 18 Feb 2002 17:14:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51466 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288308AbSBRWOq>;
	Mon, 18 Feb 2002 17:14:46 -0500
Message-ID: <3C717C72.72A994D3@zip.com.au>
Date: Mon, 18 Feb 2002 14:13:06 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john <john@zlilo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kupdated using all CPU
In-Reply-To: <20020218134041.A2586@doom.sfo.covalent.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john wrote:
> 
> hi,
> ive searched all over and found many references to this problem, but
> never found an actual solution.  the problem is that during heavy
> disk I/O, kupdated will periodically take up ALL the cpu.  

I've seen a couple of reports of this, nothing to indicate that it's
a common problem?

In the other reports, it was related to extremely low disk throughput.
What does `hdparm -t /dev/hda' say?

-
