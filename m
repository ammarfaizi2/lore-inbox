Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTDKRqP (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTDKRqP (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:46:15 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:62889 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S261246AbTDKRqN (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 13:46:13 -0400
Date: Fri, 11 Apr 2003 10:57:37 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Giuliano Pochini <pochini@shiny.it>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain
Message-ID: <20030411175736.GY31739@ca-server1.us.oracle.com>
References: <200304101339.49895.pbadari@us.ibm.com> <XFMail.20030411100430.pochini@shiny.it> <20030411154450.GW31739@ca-server1.us.oracle.com> <200304110928.32978.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304110928.32978.pbadari@us.ibm.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 08:28:32AM -0800, Badari Pulavarty wrote:
> Well !! My patch does not have anything hardcoded to 4000.
> Depends on how many minor bits. But we have to put a hardlimit
> somewhere ..

	Yes, but that hardlimit has to expect the number to be Very
Large in the very near future.  16K disks on a big compute farm is not
too far off.

> Fortunately, the multipath solution Mike Anderson & Patrick Mansfield
> working on, colapses all the disks you see thro multiple paths into 
> number of  realdisks (4000). So you don't really need extra devices 
> to support multipathing.

	Yes, but what if I want to see the multiple paths?  Does their
solution allow you to specify the path behind the 'realdisk'?  Does it
allow querying of the paths?

Joel

-- 

Life's Little Instruction Book #451

	"Don't be afraid to say, 'I'm sorry.'"

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
