Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTLELoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 06:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTLELoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 06:44:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35225 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263866AbTLELoC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 06:44:02 -0500
Date: Fri, 5 Dec 2003 11:44:00 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andy Isaacson <adi@hexapodia.org>, Rob Landley <rob@landley.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031205114400.GD10421@parcelfarce.linux.theplanet.co.uk>
References: <200312041432.23907.rob@landley.net> <20031204172348.A14054@hexapodia.org> <Pine.SOL.4.58.0312051119240.9902@green.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.58.0312051119240.9902@green.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 11:22:01AM +0000, Anton Altaparmakov wrote:
> On Thu, 4 Dec 2003, Andy Isaacson wrote:
> > On Thu, Dec 04, 2003 at 02:32:23PM -0600, Rob Landley wrote:
> > I'm curious -- does NTFS implement sparse files?  Does the Win32 API
> > provide any way to manipulate them?  Does the NT kernel have any sparse
> > file handling?
> 
> Yes it does.  The new NTFS Linux driver has full support for sparse files
> as does Windows of course.
> 
> Windows does provide a function which is just "make hole".  It takes
> starting offset and length (or was it ending offset instead of length,
> can't remember) and makes this sparse (obviously aligning to cluster
> boundaries, etc).

Have fun getting it to play nice with mmap()...
