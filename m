Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316963AbSFKJMD>; Tue, 11 Jun 2002 05:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316964AbSFKJMB>; Tue, 11 Jun 2002 05:12:01 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:49494 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316963AbSFKJLV>; Tue, 11 Jun 2002 05:11:21 -0400
Date: Tue, 11 Jun 2002 10:10:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
In-Reply-To: <3D05A6A1.328B7FDE@zip.com.au>
Message-ID: <Pine.LNX.4.21.0206111006300.1028-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Andrew Morton wrote:
> 
> I think it's too late to fix this in 2.4.  If we did, a person
> could develop and test an application on 2.4.21, ship it, then
> find that it fails on millions of 2.4.17 machines.

Oh, please reconsider that!  Doesn't loss of modification time
approach data loss?  Surely we'll continue to fix any data loss
issues in 2.4, and be grateful if you fixed this mmap modtime loss.

Hugh

