Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270712AbRHNTbZ>; Tue, 14 Aug 2001 15:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270757AbRHNTbN>; Tue, 14 Aug 2001 15:31:13 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:18074 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S270753AbRHNTa6>; Tue, 14 Aug 2001 15:30:58 -0400
Message-ID: <3B794D30.5549DE71@ameritech.net>
Date: Tue, 14 Aug 2001 11:09:20 -0500
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: NTFS R-Only error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following command fails for DLL files (not exe) in my WINNT
partition.
(windows 2000)

I am not sure who currently maintains the NTFS driver so I am posting it
here. It doesn't look to be in the kernel so maybe mount or shell?

[root@dali system32]# strings *.dll | grep -i root
Root Entry
.?AVCComObjectRootBase@ATL@@
.?AV?$CComObjectRootEx@VCComSingleThreadModel@ATL@@@ATL@@
.?AV?$CComObjectRootEx@VCComMultiThreadModel@ATL@@@ATL@@
?GetRoot@KcCatalog@@QAEPAVKcFolderEntry@@XZ
@(#)$Id: ss_root.c,v 1.10 1998/02/26 10:43:49 johns LADS451 $
Root Entry
%SystemRoot%
SystemRoot
HKEY_CLASSES_ROOT
.?AVCComObjectRootBase@ATL@@
.?AV?$CComObjectRootEx@VCComMultiThreadModel@ATL@@@ATL@@
.?AV?$CComObjectRootEx@VCComMultiThreadModelNoCS@ATL@@@ATL@@
BFD: BFD internal error, aborting at coffcode.h line 749 in
styp_to_sec_flags

BFD: Please report this bug.

uname -a
Linux dali.x.com 2.4.7 #2 Thu Jul 26 01:42:19 CDT 2001 i686 unknown

I don't see coffcode.h in the linux kernel and don't know what BFD is
in.
