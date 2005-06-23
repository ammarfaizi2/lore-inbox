Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVFWKtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVFWKtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVFWKsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:48:45 -0400
Received: from mail.enyo.de ([212.9.189.167]:17157 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262286AbVFWKp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 06:45:27 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olaf Kirch <okir@suse.de>
Subject: Re: Potential xdr_xcode_array2 security issue
References: <200506230502.j5N52PWP007955@hera.kernel.org>
	<87y8911v46.fsf@deneb.enyo.de> <200506231153.41318.agruen@suse.de>
Date: Thu, 23 Jun 2005 12:45:06 +0200
In-Reply-To: <200506231153.41318.agruen@suse.de> (Andreas Gruenbacher's
	message of "Thu, 23 Jun 2005 11:53:41 +0200")
Message-ID: <87hdfpz70t.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Gruenbacher:

> On Thursday 23 June 2005 07:48, Florian Weimer wrote:
>> This looks suspiciously like CVE-2002-0391.
>
> Thanks, Florian. How about the attached patch?

I don't know the code, so I can't tell if you must protect against
desc->elem_size beign zero.  I also don't understand the second hunk.
