Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTJIRPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbTJIRPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:15:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22286 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262288AbTJIRPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:15:54 -0400
Date: Thu, 9 Oct 2003 13:15:44 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Tom Zanussi <zanussi@us.ibm.com>
cc: linux-kernel@vger.kernel.org, <karim@opersys.com>, <bob@watson.ibm.com>
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
In-Reply-To: <16261.32253.607756.900278@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, Tom Zanussi wrote:

> Nothing, if they meet your needs.  One thing you can do with relayfs
> files is mmap() them.  That combined with the kernel-side API,
> designed to make writing data into buffers and transferring it as
> large blocks to user-space efficient and flexible, allows for
> high-speed, high-volume applications which I'm not sure Netlink was
> designed for.

It should be possible to make Netlink sockets mmapable (like the packet 
socket).

> relayfs can also be used in 'packet' mode, using read(2) to read data
> as it becomes available, so it can be used for low-speed, low-volume
> applications as well.  Also, some people might find the file-based
> approach more natural to deal with.  Personal preference, I suppose.

There is already a netlink device.


- James
-- 
James Morris
<jmorris@redhat.com>


