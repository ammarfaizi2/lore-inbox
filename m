Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290259AbSBKTcj>; Mon, 11 Feb 2002 14:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290249AbSBKTca>; Mon, 11 Feb 2002 14:32:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43532 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290125AbSBKTcZ>;
	Mon, 11 Feb 2002 14:32:25 -0500
Message-ID: <3C681C1D.9D9819BF@zip.com.au>
Date: Mon, 11 Feb 2002 11:31:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Hars <florian@hars.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disk-I/O and kupdated@99.9% system (2.4.18-pre9)
In-Reply-To: <20020208164250.GA321@bik-gmbh.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Hars wrote:
> 
> I have an ext[23] filesystem (doesn't matter which), on an LVM Volume.
> Whenever I do some heavy disk-I/O (like untaring an archive with 13000
> files that amount to 5GB), the CPU-state repeatedly goes to 99.9%
> system and stays there for a noticeable amount of time (1-2 seconds),
> during which the system doesn't respond very well to user action, to put
> it mildly.

A kernel profile will presumably point us at the problem.

It's pretty simple. See
http://www.uwsg.iu.edu/hypermail/linux/kernel/0201.3/0773.html

-
