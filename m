Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbULNWiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbULNWiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbULNWfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:35:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25011 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261694AbULNWdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:33:24 -0500
Date: Tue, 14 Dec 2004 14:33:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: libc-alpha@sources.redhat.com
cc: Roland McGrath <roland@redhat.com>, george@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Support for additional kernel clocks in glibc
Message-ID: <Pine.LNX.4.58.0412141431230.4769@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Roland McGrath wrote:

> > It seems that this code does now support extra clocks like
> > CLOCK_REALTIME_HR, CLOCK_MONOTONIC_HR and CLOCK_SGI_CYCLE right?
>
> Here I think you are talking about glibc, not kernel code.  If you mean
> this about the kernel code, then please clarify (and I'm not sure what the
> question means in that context).  If you are asking about the glibc code,
> please take that to the libc mailing list and we won't bother the kernel
> folks with that discussion.

The clock_id's are now passed through since you also have to pass your
bitmapped performance clocks through. I think this may also satisfy
George Anzinger's long standing request for the possibility of additional
clock support in glibc. The clocks are now defined only in the
kernel header files though.

Could you make the three clocks also available in glibc header files?
What do we do if additional clocks become available through the posix
layer in Linux?

