Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310819AbSCHSpH>; Fri, 8 Mar 2002 13:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310868AbSCHSos>; Fri, 8 Mar 2002 13:44:48 -0500
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:45988
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S310819AbSCHSoj>; Fri, 8 Mar 2002 13:44:39 -0500
Subject: Re: 2.4.18-rc4-aa1 XFS oopses caused by cpio
From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
To: Stephen Lord <lord@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <3C88CB1C.90203@sgi.com>
In-Reply-To: <1015580766.20800.3.camel@svetljo.st-peter.stw.uni-erlangen.de>
	<3C88B612.1070206@sgi.com> <3C88C9A1.5070502@st-peter.stw.uni-erlangen.de> 
	<3C88CB1C.90203@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-4mdk 
Date: 08 Mar 2002 19:45:23 +0100
Message-Id: <1015613123.4301.11.camel@svetljo.st-peter.stw.uni-erlangen.de>
Mime-Version: 1.0
X-Scanner: exiscan *16jPLl-0007CL-00*xB8nuNe7t/k* (Studentenwohnanlage Nuernberg St.-Peter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
seems to work now
created a 1 Gib lv, formated it, extended with 2 Gib , extended the fs
and transfered about 1,5 Gib over it 
No troubles

thanks for the fix

:)

svetljo

and 
a stupid question
is there a way to limit the I/O request that XFS sends to the lower
layer ( soft RAID or lvm ) without need to modify existing fs 
just a hack until the raid-0 code in 2.5 is fixed

i'm talking about this:
> raid0_make_request bug: can't convert block across chunks or bigger
> than 16k 23610115 64
i posted already twice to lkml and linux-xfs
and i got answer that the raid is not ready but it's worked on

thanks

svetljo

