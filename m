Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWEWWQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWEWWQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWEWWQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:16:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30183 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932192AbWEWWQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:16:52 -0400
Date: Tue, 23 May 2006 23:15:47 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Evan Harris <eharris@puremagic.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ext3-fs transient corruption with devmapper over md raid, kernel 2.6.16.14
Message-ID: <20060523221547.GA1002@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Evan Harris <eharris@puremagic.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0605231225450.11814@kinison.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0605231225450.11814@kinison.puremagic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 01:26:32PM -0500, Evan Harris wrote:
> I just recently upgraded a machine to use devmapper for an encrypted 
> filesystem on top of a software raid5 array.  System is running a 
> stock 2.6.16.14 kernel with no additional patches.
 
> Happy to provide any further info that may be useful.

This might not be practical for you, but what we're looking for
is people who can reproduce this on a test system where they can
try varying things one-at-a-time.  For example, replace dm-crypt
with dm-linear (e.g. a standard unencrypted LVM2 logical volume); 
replace raid5 with (md) linear.  Also test with the latest 
development kernels to see if recent md patches fixed the problem.
 
Alasdair
-- 
agk@redhat.com
