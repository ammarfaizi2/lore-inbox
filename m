Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318781AbSHGRkT>; Wed, 7 Aug 2002 13:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSHGRkS>; Wed, 7 Aug 2002 13:40:18 -0400
Received: from pat.uio.no ([129.240.130.16]:21973 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318781AbSHGRkS>;
	Wed, 7 Aug 2002 13:40:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15697.23640.938725.914093@charged.uio.no>
Date: Wed, 7 Aug 2002 19:43:52 +0200
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>,
       "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E114E1@ntserver2>
References: <EE83E551E08D1D43AD52D50B9F511092E114E1@ntserver2>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Gregory Giguashvili <Gregoryg@ParadigmGeo.com> writes:

     > In what I see, a simple test doesn't work in the expected way,
     > which is one client writes to a file opened with O_SYNC on a
     > drive mounted with sync option and the other client cannot
     > immediatelly see the written data.  Are you saying that this is
     > the way it should be?

Yes. That is all the NFS protocol allows you to do.

Cheers,
  Trond
