Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUASUNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUASUNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:13:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57018 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262730AbUASUNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:13:22 -0500
Date: Mon, 19 Jan 2004 15:13:15 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Clay Haapala <chaapala@cisco.com>
cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Add CRC32C chksums to crypto routines
In-Reply-To: <yqujisje43q9.fsf@chaapala-lnx2.cisco.com>
Message-ID: <Xine.LNX.4.44.0401191512140.1564-100000@thoron.boston.redhat.com>
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

Looks good to me.


- James
-- 
James Morris
<jmorris@redhat.com>


