Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312643AbSCZSWy>; Tue, 26 Mar 2002 13:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312670AbSCZSWo>; Tue, 26 Mar 2002 13:22:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51977 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312643AbSCZSWh>;
	Tue, 26 Mar 2002 13:22:37 -0500
Message-ID: <3CA0BC00.54F608D6@zip.com.au>
Date: Tue, 26 Mar 2002 10:20:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mcp@linux-systeme.de
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 problems
In-Reply-To: <200203261101.g2QB1PEI027746@codeman.linux-systeme.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:
> 
> Hi there,
> 
> kernel: EXT3-fs warning (device ide0(3,10)): ext3_unlink: Deleting
> nonexistent file (32650)
> 
> Since 2.4.18 i get sometimes the above message. What is it?
> 

Well that's clever of you :)  According to google, only
one other person has ever hit this with ext3.  Several
people have hit it on ext2.  It does appear to be related
to I/O errors on the underlying device.

Could you please force a fsck against that filesystem and
also check you logs for any disk I/O warnings.

-
