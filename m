Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUANVqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUANVqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:46:09 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:5735 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263893AbUANVqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:46:05 -0500
Date: Wed, 14 Jan 2004 16:45:49 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Clay Haapala <chaapala@cisco.com>
cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Add CRC32C chksums to crypto routines
In-Reply-To: <yqujisje43q9.fsf@chaapala-lnx2.cisco.com>
Message-ID: <Xine.LNX.4.44.0401141643560.12649-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004, Clay Haapala wrote:

> This patch against 2.6.1 adds CRC32C checksumming capabilities to the
> crypto routines.  The structure of it is based wholly on the existing
> digest (md5) routines, the main difference being that chksums are
> often used in an "accumulator" fashion, effectively requiring one to
> set the seed, and the digest algorithms don't do that.

This looks interesting; do you know of any other chksum algorithms which
might need to be implemented in the kernel?


- james
-- 
James Morris
<jmorris@redhat.com>


