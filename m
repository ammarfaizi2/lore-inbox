Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTLKWCF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 17:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTLKWCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 17:02:05 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:10648 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262772AbTLKWCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 17:02:03 -0500
Date: Thu, 11 Dec 2003 17:02:01 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mem: and Swap: lines in /proc/meminfo
In-Reply-To: <20031209000021.GA8402@mis-mike-wstn.matchmail.com>
Message-ID: <Pine.LNX.4.44.0312111701330.15419-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, Mike Fedyk wrote:

> Now I need to change the order (it is using Mem: and Swap: first, and the
> other more thurough method second), but I'm wondering what versions of the
> kernel I'd be cutting out if I just removed the parsing of Mem: and Swap:...

IIRC 2.2 kernels already had the one-value-per-line
memory statistics, so you'd only lose 2.0 and earlier.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

