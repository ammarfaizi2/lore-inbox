Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUDOIIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 04:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbUDOIIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 04:08:43 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:1677 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261915AbUDOIIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 04:08:41 -0400
Date: Thu, 15 Apr 2004 09:08:40 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Nasir Hossain <sonu_hack@gawab.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LDM code query
In-Reply-To: <1081854562.6418.3.camel@localhost.localdomain>
Message-ID: <Pine.SOL.4.58.0404150907400.18088@orange.csi.cam.ac.uk>
References: <1081854562.6418.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Nasir Hossain wrote:
> can someone tell me what this macro does :
>
> __be64_to_cpu()
> __be32_to_cpu()
> __be16_to_cpu()
>
> something to do with big endian (i guess).
>
> found this while going thru the ldmutil (LDM) code.

You guess correctly.  These macros convert big endian numbers to cpu
format, just like the __leXX_to_cpu() convert little endian to cpu format.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
