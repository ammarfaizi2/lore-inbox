Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUC3Xd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUC3Xd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:33:59 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:39571 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S261671AbUC3Xc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:32:27 -0500
Subject: Re: NFS sloow on 2.4
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <7617358E-82A1-11D8-82F0-000A9585C204@able.es>
References: <7617358E-82A1-11D8-82F0-000A9585C204@able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1080689525.2557.91.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 30 Mar 2004 18:32:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 18:24, J.A. Magallon wrote:
> mount:
> 192.168.1.1:/home on /home type nfs 
> (rw,nfsvers=3,tcp,rsize=8192,wsize=8192,noac,addr=192.168.1.1)

Turn off "noac": That forces slooooow synchronous writes as per
Solaris...

Cheers,
  Trond
