Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319107AbSHGRyF>; Wed, 7 Aug 2002 13:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319111AbSHGRyF>; Wed, 7 Aug 2002 13:54:05 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:50284 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S319107AbSHGRyE>; Wed, 7 Aug 2002 13:54:04 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E114E2@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
Date: Wed, 7 Aug 2002 20:54:59 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>     > In what I see, a simple test doesn't work in the expected way,
>     > which is one client writes to a file opened with O_SYNC on a
>     > drive mounted with sync option and the other client cannot
>     > immediatelly see the written data.  Are you saying that this is
>     > the way it should be?
>
>Yes. That is all the NFS protocol allows you to do.

Well, this is the way it's been working on all UN*X platforms I know. In
fact, we came across this problem with NFS clients being unable to
synchronize on Linux. 
If this is a "feature", it makes it impossible to read/write files via NFS
because of the risk of corruption - or am I missing something here?

Also, integrating Linux into heterogeneous networks becomes impossible
(though, it doesn't work in Linux only network as well).

Best,
Giga
