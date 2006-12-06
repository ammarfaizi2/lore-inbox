Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937120AbWLFS4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937120AbWLFS4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937121AbWLFS4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:56:50 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53780 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937120AbWLFS4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:56:48 -0500
Date: Wed, 6 Dec 2006 10:56:14 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: David Howells <dhowells@redhat.com>
cc: torvalds@osdl.org, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd really appreciate a cmpxchg that is generically available for 
all arches. It will allow lockless implementation for various performance 
criticial portions of the kernel.


