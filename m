Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbUCJPov (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbUCJPov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:44:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5582 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262670AbUCJPos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:44:48 -0500
Date: Wed, 10 Mar 2004 10:45:28 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jouni Malinen <jkmaline@cc.hut.fi>
cc: Clay Haapala <chaapala@cisco.com>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
In-Reply-To: <20040310053411.GB4346@jm.kir.nu>
Message-ID: <Xine.LNX.4.44.0403101044480.30984-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, Jouni Malinen wrote:

> On Tue, Mar 09, 2004 at 11:21:03PM -0500, James Morris wrote:
> 
> > In both patches, these 'return -1' statements should be -EINVAL, or 
> > whatever is appropriate (probably -ENOSYS for this one).
> 
> Fixed. The included patch combines changesets for both the setkey
> addition and Michael MIC. Please let me know if you want to get these as
> separate patch files.

This is oopsing on 'modprobe tcrypt'.

Separate patches would be preferred.


- James
-- 
James Morris
<jmorris@redhat.com>


