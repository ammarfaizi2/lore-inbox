Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266431AbUBFDue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266433AbUBFDue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:50:34 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:61901 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S266431AbUBFDud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:50:33 -0500
Date: Thu, 5 Feb 2004 22:50:24 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mmap question - it's in the man page
In-Reply-To: <7A25937D23A1E64C8E93CB4A50509C2A0310F094@stca204a.bus.sc.rolm.com>
Message-ID: <Pine.LNX.4.44.0402052249320.5933-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Bloch, Jack wrote:

> Is there any clear explanation of what the offset parameter in the mmap
> system call means? Please CC me on any response.

The following command will reveal all:

$ man 2 mmap

DESCRIPTION
       The mmap function asks to map  length  bytes  starting  at
       offset offset from the file (or other object) specified by
       ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

