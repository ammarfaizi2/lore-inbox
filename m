Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286220AbSAKRMn>; Fri, 11 Jan 2002 12:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290029AbSAKRMd>; Fri, 11 Jan 2002 12:12:33 -0500
Received: from petasus.iil.intel.com ([192.198.152.69]:37313 "EHLO
	petasus.iil.intel.com") by vger.kernel.org with ESMTP
	id <S286220AbSAKRMS>; Fri, 11 Jan 2002 12:12:18 -0500
Message-ID: <3C3F1CD0.2030202@intel.com>
Date: Fri, 11 Jan 2002 19:11:44 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Organization: Intel
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: __FUNCTION__ - continue
Content-Type: multipart/mixed;
 boundary="------------010002070709070805070404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010002070709070805070404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I am continue looking at __FUNCTION__ use in context where it 
concatenates with another string. This time I attached little patch that 
just fixes /include subtree. This patch do not change format of messages 
printed, it just uses __FUNCTION__ as gcc 3 suggests.
Patch is against 2.4.18-pre3

All /include subtree is fixed, except /include/asm-mips/system.h (it 
requires small changes in /arch/mips/kernel/traps.c)

I will come with separate fix for it, it's easy to do, I just wonder 
whether this issue is interesting and patches going to be used. 
Otherwise, I don't want to spend time for this technical and not very 
interesting work.

P.S. Marcelo, if you are reading it - your opinion, is this issue worth 
the effort?


--------------010002070709070805070404
Content-Type: application/x-gzip;
 name="__FUNCTION__.include.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="__FUNCTION__.include.patch.gz"

H4sICBoYPzwCA19fRlVOQ1RJT05fXy5pbmNsdWRlLnBhdGNoALVWbW/aSBD+HP+KqSNOdsAY
CEmoo/RCwKQ01Il4ke50Oa0cvC7bmLXllzbXKv/9Zm1eTCAXuOOMBIt35tnZneeZWYe5LmhJ
CNpvoE/8KdW/PfrcCW3N0z32oDs+jx1h4zGePGm1cr1cbWhBSI/Lfsi+6IyPvcShejqtf31w
ypMNpoEdjyfU2WQtaZq2A/hBJ2TQpmOoVaH63qjXjMox1CqVqlQsFndbOYX6ZHOoIlTDqDWM
SkVA1aTLS9DOavXSGRSzn8tLCSQ4dKjLOAX0JqZ1O/h9oKhwL4Hjw8+D2QPpcy9pB0HIePwI
yo3Zt4jZ74P86aoNCWfTwKNTymPqgJvwccx8DjIQ0hlZrWH31iJEPUeE4m4IhUgurYPAwTgJ
QzTVPkSxHVO4gGFzcENGVtcaIuTobti96pnnucjhIBInlnhUUc9XNwXP8H3CPApKVZWcvTIn
pCyioRsRN9qBQSte2zNpxW0/jFqHXDLruGKc1HLMOi01kFjiW/Bqzqp+czAw+0MFxniKJXD9
cGrHJbDDL1G5XAY1zQTmgLkKvMusQMXPnHk4BbAII7A5GytQKYE8f/dHgf1pgB3hnxnnDlMQ
GVwbk+qAHYMscDSRcaRSt2cSArJRYMYqP/Gd8EojBPmey6WFG+MESUvDMAliVMevoFXBgBkJ
QfsAAXMET3tdS4CX4PBQ7BBU5PvaqoVofR148dxnjjuvm99PLgohc+ZClhNHgdat1elek77Z
xeR0BqT10WzdCLtF2jrN3sB8NWvLtC5ytrRarLpnLcWcxjh83EVJS58ddLR02pOKXgDmNFQ3
6idLDZ00TkvvoZj9CBXRJ0w+h28+c2CBgpRgsSLeqef5Ap6lhPSHVg+5Iso3qgoUx//OSRz+
5fnjR+UXRPFIRKcqXFxARQU0SoLca1FetaxEK7KAymsrp6gcp5WCo65JSdB6QUxEfRaU/he4
hWgFaa0ZPKe1XehnVsWVCp6KNj+Tq9E1Gfabd8qTmh7GOxyouOd5JKIJmSuxKFhAnkBW/9Nm
peL/G8CbpyJ4gcygHPUF+hHOZwshwpG+N2EiIfUHL6Gx78eTdPRjK3Fu9NtGoBsdU00NaABw
JkSKN57jxi4ifR00J9RTxM0JNW12J/Nml5dp6k+cZBoo44kdwhGu6YoEJQ04ekhwiInHmpnw
eFW+XaujuNOsymKRVecUSe9JOHkLOJtyLe0vwkxdEr19df2G94ZW9w94eIt6HU/c2rbDK24f
nzzrizOQ9V72AvHtCLdEzJojosLHVpe0m8MmaY8+3y0z0/58p6SZ8yhXRXfO5XgVcmEl/Q1C
xuU1ggwAAA==
--------------010002070709070805070404--

