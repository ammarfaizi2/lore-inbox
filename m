Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264032AbTJ1QpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbTJ1QpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:45:19 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:29271 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264032AbTJ1QpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:45:16 -0500
Date: Tue, 28 Oct 2003 11:45:14 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: James Morris <jmorris@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make selinux LSM vm_enough_memory call stackable
In-Reply-To: <Pine.LNX.4.44.0310281138041.24733-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0310281142090.24733-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003, Rik van Riel wrote:

> the following (trivial, but untested) patch

Hmmm, wait, this patch is TOO trivial and will result in
memory being accounted multiple times.

Making this piece of code stackable is a bit harder than
I thought at first. I have some ideas on how to do it,
but not yet any ideas on how to do it cleanly ...

Guess I'll be back with another patch soon ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

