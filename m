Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbTIDO2C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265034AbTIDO2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:28:02 -0400
Received: from mail3-126.ewetel.de ([212.6.122.126]:58338 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S265022AbTIDO1E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:27:04 -0400
Date: Thu, 4 Sep 2003 16:27:01 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS] attempt to use V1 mount protocol on V3 server
In-Reply-To: <16214.49538.216630.336724@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0309041621180.989-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Trond Myklebust wrote:

> Most are not. An NFSv3 filehandle has a variable size (as opposed to
> NFSv2 which are fixed size), and so most NFS servers use the same
> filehandle for NFSv2 and NFSv3.

Well, my filehandles are all 64 bytes at the moment. Doesn't matter
anyway since my nfsd does not handle NFSv2.

> Note: The fact that we are now stuck with a schizophrenic NFSv3 client
> is one of the many reasons why I am now *very* wary of trying to work
> around server bugs by making fixes to the client code.

Fine with me if a buggy server results in a failure to mount. However,
I was seeing crashes.

-- 
Ciao,
Pascal

