Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTLELW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 06:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTLELW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 06:22:27 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:36255 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP id S263914AbTLELW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 06:22:26 -0500
Date: Fri, 5 Dec 2003 11:22:01 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andy Isaacson <adi@hexapodia.org>
cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
In-Reply-To: <20031204172348.A14054@hexapodia.org>
Message-ID: <Pine.SOL.4.58.0312051119240.9902@green.csi.cam.ac.uk>
References: <200312041432.23907.rob@landley.net> <20031204172348.A14054@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003, Andy Isaacson wrote:
> On Thu, Dec 04, 2003 at 02:32:23PM -0600, Rob Landley wrote:
> I'm curious -- does NTFS implement sparse files?  Does the Win32 API
> provide any way to manipulate them?  Does the NT kernel have any sparse
> file handling?

Yes it does.  The new NTFS Linux driver has full support for sparse files
as does Windows of course.

Windows does provide a function which is just "make hole".  It takes
starting offset and length (or was it ending offset instead of length,
can't remember) and makes this sparse (obviously aligning to cluster
boundaries, etc).

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
