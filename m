Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310145AbSCAHSB>; Fri, 1 Mar 2002 02:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310362AbSCAHQE>; Fri, 1 Mar 2002 02:16:04 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:6923 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S310359AbSCAHOj>; Fri, 1 Mar 2002 02:14:39 -0500
Date: Fri, 1 Mar 2002 08:14:10 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Val Henson <val@nmt.edu>,
        "Randy.Dunlap" <rddunlap@osdl.org>, Laurent <laurent@augias.org>,
        linux-kernel@vger.kernel.org
Subject: Re: read_proc issue
Message-ID: <20020301071410.GA11256@arthur.ubicom.tudelft.nl>
In-Reply-To: <20020227140432.L20918@boardwalk> <E16gBps-0005wa-00@the-village.bc.nu> <20020228000532.GA8858@arthur.ubicom.tudelft.nl> <E16fucy-0004vi-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16fucy-0004vi-00@starship.berlin>
User-Agent: Mutt/1.3.27i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 04:19:35AM +0100, Daniel Phillips wrote:
> On February 28, 2002 01:05 am, Erik Mouw wrote:
> > It might also be an idea to export proc_calc_metrics() from
> > fs/proc/proc_misc.c because quite a lot of code actually tries to do
> > exactly the same.
> 
> Look at all the parameters, they're trying to be a struct.  How about
> cleaning it up before exporting?

Look at all the parameters of a procfs read() function and compare them
with the parameters of proc_calc_metrics(). See why cleaning up
would make things only more complicated?


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
