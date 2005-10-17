Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVJQOSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVJQOSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 10:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVJQOSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 10:18:16 -0400
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:11477 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S1751354AbVJQOSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 10:18:15 -0400
Message-ID: <4353B297.5080604@moving-picture.com>
Date: Mon, 17 Oct 2005 15:17:59 +0100
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ruediger@Theo-Phys.Uni-Essen.DE
Subject: Re: NFS client problem with kernel 2.6 and SGI IRIX 6.5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The summary is as follows: I do have problems with the 2.6 series
> kernel, which do not occur with a 2.4 series kernel (and an other-
> wise unchanged system). I discovered it with Mathematica version 5.0,
> but do think that other programs are also involved (e.g. OpenOffice
> 1.1.4, that doesn't find its default (or any other) printer any
> longer). The symptom is, that certain ressources are reported
> missing, that are definitively there and which lie somewhere
> within the application-tree, that tree lying within a hierarchie
> being nfs-auto-mounted from the SGI system to the (Intel architec-
> ture) Linux client. File contents (or whole files?) seems to get
> 'lost' somehow.
> 
> It doesn't seem to be the MSBit Problem of the 32bit nfs cookies
> (alone) - the branch is exported with the IRIX '32bitclients'
> option, to avoid the 64bit cookies, that led to a similar problem
> with the printer in OpenOffice under the 2.4 series kernels, and
> vanished with the 32bit-option.  The reason for me to state this
> is, that when I applied a 32bit-'SGI-IRIX-induced'-patch for (early)
> 2.6 kernels (Debians 2.6.8) the problem didn't go away, and it also
> still occurs when using the 2.6.12-kernel, where some kernel-version
> ago (2.6.10 or 11?) that part of the cookie problem was solved via a
> translation table (once and for all, I hope).
> 
> The problem occurs when requesting nfs v2 as well as nfs v3 protocol.
> An LD_ASSUME_KERNEL does not seem to help, as it does with other
> problems.
> 
> When testing or compiling kernels, I always used the 'debianized'
> versions, but to my understanding, they are nearly unaltered compared
> to the 'plain' kernels (see Debian changelogs).
> 
> The problem is severe to us, as the same configuration also exports
> our home-directories, which are, of course, writeable, contrary to
> the application-tree, which is read-only. Thus any help will be
> welcome.
> 
> I'm willing to try whatever I can do to resolve the problem, but I
> need guidance in what to do and what (else) you need to know.

Is this similar to the issue in the following thread? :

http://marc.theaimsgroup.com/?l=linux-kernel&m=108741268200839&w=2

James Pearson
