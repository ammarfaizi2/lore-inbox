Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTDITtB (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTDITtB (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:49:01 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:47803 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S263769AbTDITtA (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 15:49:00 -0400
Date: Wed, 9 Apr 2003 10:59:14 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT alignment requirements ?
Message-ID: <20030409175908.GB31739@ca-server1.us.oracle.com>
References: <Joel.Becker@oracle.com> <20030409154836.GA31739@ca-server1.us.oracle.com> <200304091653.h39GrHR05341@verdi.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304091653.h39GrHR05341@verdi.et.tudelft.nl>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 06:53:17PM +0200, Rob van Nieuwkerk wrote:
> I get 4096 with BLKBSZGET on several unmounted partitions on my system
> (RH 2.4.18-27.7.x kernel).  Some give 1024 ..  Maybe it is because I
> had them mounted first and unmounted them for the test ?

	That would be the most likely answer.  When you unmount, I don't
believe the filesystem bothers to set_blocksize(get_hardsect_size(dev)).

Joel

-- 

Life's Little Instruction Book #94

	"Make it a habit to do nice things for people who 
	 will never find out."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
