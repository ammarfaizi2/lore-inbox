Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbTIPPyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbTIPPyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:54:39 -0400
Received: from math.ut.ee ([193.40.5.125]:42942 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261963AbTIPPyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:54:37 -0400
Date: Tue, 16 Sep 2003 18:54:34 +0300 (EEST)
From: Meelis Roos <mroos@math.ut.ee>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: df hangs on nfs automounter in 2.6.0-current
In-Reply-To: <shsznh4d9g7.fsf@charged.uio.no>
Message-ID: <Pine.GSO.4.44.0309161853300.25512-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      > Current 2.6.0 (2.6.0-test5+BK as of 16.09) hangs on df when the
>      > am_utils automounter is in use. It displays hda* partitions and
>      > next by mountpoint list is amd but then df hangs, wchan is
>      > rpc_execu*
>
> Please reproduce using ordinary 'mount'...

Seems that am-utils (or other userland) is at fault - it breaks with
2.4.23-pre4 too...

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/

