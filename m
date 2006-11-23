Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934176AbWKWWHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934176AbWKWWHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 17:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934175AbWKWWHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 17:07:53 -0500
Received: from mail.aconex.com ([150.101.159.26]:40426 "EHLO
	page.mel.office.aconex.com") by vger.kernel.org with ESMTP
	id S934173AbWKWWHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 17:07:51 -0500
Subject: Re: [xfs-masters] Re: 2.6.19-rc6 : Spontaneous reboots, stack
	overflows - seems to implicate xfs, scsi, networking, SMP
From: Nathan Scott <nscott@aconex.com>
Reply-To: nscott@aconex.com
To: xfs-masters@oss.sgi.com
Cc: Al Viro <viro@ftp.linux.org.uk>, David Miller <davem@davemloft.net>,
       dgc@sgi.com, jesper.juhl@gmail.com, chatz@melbourne.sgi.com,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <1164269545.31358.771.camel@laptopd505.fenrus.org>
References: <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com>
	 <9a8748490611220458w4d94d953v21f7a29a9f1bdb72@mail.gmail.com>
	 <20061123011809.GY37654165@melbourne.sgi.com>
	 <20061122.201013.112290046.davem@davemloft.net>
	 <20061123043543.GI3078@ftp.linux.org.uk>
	 <1164269545.31358.771.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Aconex
Date: Fri, 24 Nov 2006 09:08:45 +1100
Message-Id: <1164319725.4695.367.camel@edge>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 09:12 +0100, Arjan van de Ven wrote:
> On Thu, 2006-11-23 at 04:35 +0000, Al Viro wrote:
> > > I would even say 10 function calls deep to allocate file blocks
> > > is overkill, but 22 it just astronomically bad.
> > 
> > Especially since a large part is due to cxfs...
> > -
> 
> it's a bit sad to see XFS this crippled in linux due to an external,
> proprietary module ;(

Heh, never let reality get in the way of a good conspiracy theory.
The stack depth in XFS is more a factor of the complexity of the
XFS space allocation algorithms, and is unrelated to CXFS.

I'm sure if people would point to specific stack issues they would
(continue to) get addressed.  Its just so much easier to speculate
randomly though...

cheers.

-- 
Nathan

