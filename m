Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136802AbREISJJ>; Wed, 9 May 2001 14:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136803AbREISI7>; Wed, 9 May 2001 14:08:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:4264 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S136801AbREISIa>; Wed, 9 May 2001 14:08:30 -0400
Subject: Re: Announcing Journaled File System (JFS)  release 0.3.1 available
To: Christoph Hellwig <hch@caldera.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF1E6EA372.3C309891-ON85256A47.00629678@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Wed, 9 May 2001 13:08:14 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 05/09/2001 02:08:21 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 12:50:15PM -0500, Christoph Hellwig wrote:
>>On Wed, May 09, 2001 at 12:40:25PM -0500, Steve Best wrote:
>> Release 0.3.1 of JFS was made available today.
>>
>> Drop 31 on May 9, 2001 (jfs-0.3.1.tar.gz) includes fixes to the
>> file system and utilities.
>>
>> For more details about the problems fixed, please see the README.

> would it be possible to include the latest part of the ChangeLog (e.g.
> 0.3.0 -> 0.3.1) in the mail to allow people to get a quick overview on
> what changed when reading the mail?

Christoph,

Here is description of the changes from 0.3.0 -> 0.3.1

Function and Fixes in Utilities
- completed endian macros support needed for xpeek
- added socket support for fsck
- minor bug fixes

Function and Fixes in File System
- Removed max hard links check (showed up during cp -a /usr /jfs/usr)
- Fixed inode writing hang could have showed up running (dbench, iozone,
  etc), the change was to prevent a deadlock during inode writing.

Steve

