Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269049AbUJSIH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269049AbUJSIH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 04:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUJSIH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 04:07:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7648 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268232AbUJSIHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 04:07:22 -0400
Date: Tue, 19 Oct 2004 10:03:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ben Collins <bcollins@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, willy@debian.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: [BK PATCH] SCSI updates for 2.6.9
Message-ID: <20041019080313.GP2284@suse.de>
References: <1098137016.2011.339.camel@mulgrave> <200410182341.13648.dtor_core@ameritech.net> <200410190012.28071.dtor_core@ameritech.net> <Pine.LNX.4.58.0410190009260.2287@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410190009260.2287@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19 2004, Linus Torvalds wrote:
> 
> Ben,
>  does this look ok to you?
> 
> Arguably the SCSI layer should also have proper prefixes for its constants
> - and in fact they do kind of exist as the GPCMD_xxx constants.  Oh, well.
> Regardless, the sbp2 constants do look like they want prefixing..

But only for commands (GPCMD is general packet command), not for
anything else. Would be nice to standardize prefixes for other things,
too.

-- 
Jens Axboe

