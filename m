Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262637AbREOFom>; Tue, 15 May 2001 01:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262639AbREOFoW>; Tue, 15 May 2001 01:44:22 -0400
Received: from www0q.netaddress.usa.net ([204.68.24.46]:25568 "HELO
	www0q.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S262637AbREOFoT> convert rfc822-to-8bit; Tue, 15 May 2001 01:44:19 -0400
Message-ID: <20010515054417.15472.qmail@www0q.netaddress.usa.net>
Date: 14 May 2001 23:44:17 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Inode creation
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
                  Thanks for the replies regarding inodes. From the replies I
understood that inode numbers are assigned at the time of accessing in the
case of msdos and nfs files. And it may change during running if it is not
being accessed.
                  Now the question is who is responsible for assigining the
inode numbers to files, VFS or file driver. I think it is file driver. If it
is the file driver, will it parse through inode lists(hash,dirty etc) to check
wheather the inode number is unique(inode number in a system should be unique
for a file right)
                  Now the question comes how the VFS assign inode numbers to
files for a msdos or nfs partition, I mean what is the sequence of function
calls made for assigining inode numbers to  files.
 
Thanks in advance
                                by
                                    Blesson
                  

____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
