Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUFPTU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUFPTU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUFPTU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:20:57 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:14465 "EHLO crianza")
	by vger.kernel.org with ESMTP id S264648AbUFPTUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:20:55 -0400
Date: Wed, 16 Jun 2004 15:20:55 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: NFS problem with recent 2.6 kernels (also serial console weirdness)
Message-ID: <20040616192055.GC14580@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615000436.GA12516@porto.bmb.uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615000436.GA12516@porto.bmb.uga.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 08:04:36PM -0400, foo@porto.bmb.uga.edu wrote:
> Hello, I have an x86_64 NFS server with a 32-bit userspace (debian
> woody+backports as necessary) that starts to refuse mount requests after
> a while (sometimes no time at all),  The symptom from the client side
> (tested with Linux 2.6, and Solaris 9) is this:
> 
> mount: RPC: Unable to receive; errno = Connection refused

This still happens with 2.6.7.  I did

umount -a -t nfs; mount -a

on a client and I had to restart the NFS server, portmap, etc. 4 times
to get everything mounted again.

-ryan
