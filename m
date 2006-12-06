Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937135AbWLFTDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937135AbWLFTDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937154AbWLFTDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:03:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:37071 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937135AbWLFTDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:03:35 -0500
Date: Wed, 6 Dec 2006 11:02:24 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: David Howells <dhowells@redhat.com>
cc: torvalds@osdl.org, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it [try #2]
In-Reply-To: <20061206175622.31077.96046.stgit@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0612061101110.27047@schroedinger.engr.sgi.com>
References: <20061206175622.31077.96046.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, David Howells wrote:

> Implement generic UP cmpxchg() where an arch doesn't otherwise support it.
> This assuming that the arch doesn't have support SMP without providing its own
> cmpxchg() implementation.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

I cannot evaluate the ARM implementation but otherwise.

Acked-by: Christoph Lameter <clameter@sgi.com>
