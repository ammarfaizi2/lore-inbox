Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288660AbSADO4q>; Fri, 4 Jan 2002 09:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288662AbSADO4g>; Fri, 4 Jan 2002 09:56:36 -0500
Received: from inje.iskon.hr ([213.191.128.16]:42641 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S288660AbSADO4S>;
	Fri, 4 Jan 2002 09:56:18 -0500
Date: Fri, 4 Jan 2002 15:56:11 +0100
From: Igor Briski <igorb@iskon.hr>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3fs corruption problem?
Message-ID: <20020104155611.A7833@iskon.hr>
In-Reply-To: <20011227120659.O3081@tsunami.iskon.hr> <3C2B77B9.6143EE1E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C2B77B9.6143EE1E@zip.com.au>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 11:34:17AM -0800, Andrew Morton wrote:

> > I've noticed several files missing in last few days and this
> > also started happening:
> > 
> > webmail1 [/space/cwmail/mail/n_z1/f6/jejka74_Pmail_Ixxx_Ixx/2] # ls -la
> > total 32
> > drwx--S---    2 www-data www-data     4096 Nov 25 22:47 .
> > drwx--S---    5 www-data www-data     4096 Dec 26 14:48 ..
> > -rw-r--r--    1 www-data www-data     1011 Nov 25 22:47 index.dat
> > -rw-r--r--    1 www-data www-data 18446744069414584903 Nov 23 22:25 m_0.dat
> 
> There was a truncate problem which could allow this.  It was fixed
> in 2.4.17.  Deleting the file and running fsck will clean it up.
>
> Could you please fsck the filesystems, see what it says?

Fsck found no errors. 

> Also, please check the logs for any errors or warnings from the
> filesystem and from RAID.

None found. Anyway, I've compiled 2.4.17. and it looks ok now. I've mounted
/space partition as ext3, data=writeback and found no errors in the last few
days. I'm keeping an eye on it... 

-- 
Igor Bri¹ki -- igor.briski@iskon.hr 
