Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289323AbSA1Sso>; Mon, 28 Jan 2002 13:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289320AbSA1Ssb>; Mon, 28 Jan 2002 13:48:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20228 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289319AbSA1SsU>;
	Mon, 28 Jan 2002 13:48:20 -0500
Message-ID: <3C559B3E.56D8BC2F@zip.com.au>
Date: Mon, 28 Jan 2002 10:41:02 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Assertion failure / do_get_write_acess() / loop / samba
In-Reply-To: <008f01c1a815$d8cdcc70$8a140237@rennes.si.fr.atosorigin.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yann E. MORIN" wrote:
> 
> Hi all!
> 
> I've encountered a reproductible 'Assertion failure' in 2.4.17.
> It happens on pure vanilla, as well as on sched O1-J0, and also on
> 2.4.18-pre4.
> 

Thanks.  Could you please apply the ext3 debug patch at

http://www.zip.com.au/~akpm/linux/ext3/ext3-debug-2.4.18-pre6.patch

and enable `buffer head tracing' in config (filesystems menu)
and then send the crash result to ext2-devel@lists.sourceforge.net

-
