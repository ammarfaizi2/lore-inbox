Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269757AbRHIKvq>; Thu, 9 Aug 2001 06:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269760AbRHIKvg>; Thu, 9 Aug 2001 06:51:36 -0400
Received: from atlrel6.hp.com ([192.151.27.8]:32516 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S269757AbRHIKv2>;
	Thu, 9 Aug 2001 06:51:28 -0400
Message-ID: <3B726A70.D41EEDED@india.hp.com>
Date: Thu, 09 Aug 2001 16:18:16 +0530
From: Milind <dmilind@india.hp.com>
Organization: HP
X-Mailer: Mozilla 4.7 [en] (X11; I; HP-UX B.10.20 9000/712)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: blore-linux@yahoogroups.com, gesl@yahoogroups.com
Subject: Some additions to SIZE field is that OK?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

I've found out from one of our (HP) tools, "glance tool" that, the SIZE
field is also
constituted of virtual pages used for shared-memory, u-area , mry-mapped
files,
I/O device mapping (in addtion to text,data, and stack)  pertaining to
the particular process.

Further , in case  of  LINUX it is  seen that the value for SIZE is a
single field from
'proc' file  system(i.e 23rd field in /proc/<pid>/stat file). I couldn't
get any documentation
for fields in above(stat) file in LINUX.

So we really don't know what all constitute SIZE in linux.

I wanted some elaboration on this matter.

Thanks
Milind





