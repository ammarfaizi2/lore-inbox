Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSGCDGO>; Tue, 2 Jul 2002 23:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSGCDGN>; Tue, 2 Jul 2002 23:06:13 -0400
Received: from 64-30-107-48.ftth.sac.winfirst.net ([64.30.107.48]:9476 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S314548AbSGCDGL>; Tue, 2 Jul 2002 23:06:11 -0400
Subject: Re: Loopback + NFS: files copied partially with bogus error message.
From: Manuel McLure <manuel@mclure.org>
To: Manuel McLure <manuel@mclure.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1025588128.13795.13.camel@ulthar.internal.mclure.org>
References: <1025588128.13795.13.camel@ulthar.internal.mclure.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Jul 2002 20:08:38 -0700
Message-Id: <1025665719.2338.1.camel@ulthar.internal.mclure.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-01 at 22:35, Manuel McLure wrote:
> I'm running two machines, one ("leng") running a Red Hat 2.4.9-31
> kernel, the other ("ulthar") running a 2.4.18+lowlatency kernel. On
> "leng", I have ISO images of the Red Hat 7.3 install CDs mounted through
> loopback, and exported via NFS. "ulthar" mounts the images via NFS from
> "leng":
... it does a partial copy and then fails with a "No such
> file or directory" error. The size of the file after the failed copy
> varies - sometimes I've seen up to 26MB be copied (the actual size of
> the file is 42M). No errors are listed in the system logs of either
> system. Copies from the loopback filesystem to a local file on "leng"
> succeed, as are copies from an ext3 filesystem on "leng" to "ulthar"
> over NFS - the problem only seems to happen with the combination.

I upgraded the OS version on "leng" to Red Hat 7.3 with kernel 2.4.18-5
and the problem seems to be fixed, so never mind.

-- 
Manuel A. McLure KE6TAW <manuel@mclure.org> <http://www.mclure.org>
...for in Ulthar, according to an ancient and significant law,
no man may kill a cat.                       -- H.P. Lovecraft

