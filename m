Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVCPOGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVCPOGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVCPOGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:06:24 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:28074 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262593AbVCPOGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:06:13 -0500
Date: Wed, 16 Mar 2005 09:06:10 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: jmerkey <jmerkey@utah-nac.org>, Bernd Eckenfels <ecki@lina.inka.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Devices/Partitions over 2TB
Message-ID: <20050316140610.GG17865@csclub.uwaterloo.ca>
References: <E1DB3yF-0002BK-00@calista.eckenfels.6bone.ka-ip.net> <42366A79.2080609@utah-nac.org> <1110975416.1959.21.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110975416.1959.21.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 12:16:57PM +0000, Stephen C. Tweedie wrote:
> For LVM, the lvm2 package contains all the necessary tools.  I know
> Alasdair did some kernel fixes for lvm2 striping on >2TB partitions
> recently, though, so older kernels might not work perfectly if you're
> using stripes.
> 
> To use genuine partitions > 2TB, though, you need alternative
> partitioning; the GPT disk label supports that, and "parted" can create
> and partition such disk labels.  (Note that most x86 BIOSes can't boot
> off them, though, so don't do this on your boot disk!)

Does the BIOS actually support partitions in general?  I thought that
was a problem for the code in the MBR.  As long as your bootcode in the
MBR supports whatever partition scheme you come up with, I can't see how
it should be a problem, but maybe I am missing something.  So what does
GRUB/LILO support?

Len Sorensen
