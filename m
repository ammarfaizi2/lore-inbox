Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbULTUPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbULTUPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 15:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbULTUPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 15:15:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:3972 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261631AbULTUPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 15:15:12 -0500
Date: Mon, 20 Dec 2004 12:15:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out CPU clock additions to posix-timers
In-Reply-To: <200412201937.iBKJbl9r012165@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0412201212150.7400@schroedinger.engr.sgi.com>
References: <200412201937.iBKJbl9r012165@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Roland McGrath wrote:

> > The conservative line is to keep a consistent definition of the interface
> > following posix as closely as possible.
>
> The conservative line for Linux is to not change the interface from 2.6.9,
> period.  If Andrew prefers the partial changes, I don't have a strong
> objection.  But it is by no means the conservative thing to do.

Conservative means minimal changes to the existing tested code of
2.6.10-rcX and reduction of a potential future flux in the kernel API.
