Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264535AbSIWFAA>; Mon, 23 Sep 2002 01:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264537AbSIWFAA>; Mon, 23 Sep 2002 01:00:00 -0400
Received: from holomorphy.com ([66.224.33.161]:9876 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264535AbSIWE76>;
	Mon, 23 Sep 2002 00:59:58 -0400
Date: Sun, 22 Sep 2002 21:56:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <aebr@win.tue.nl>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <20020923045616.GW3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	linux-kernel@vger.kernel.org
References: <20020921161702.GA709@iucha.net> <597384533.1032600316@[10.10.2.3]> <20020921185939.GA1771@iucha.net> <20020921202353.GA15661@win.tue.nl> <20020922043050.GU3530@holomorphy.com> <20020922062702.GA652@iucha.net> <20020923045617.GA726@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020923045617.GA726@iucha.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 11:56:17PM -0500, Florin Iucha wrote:
> The lockup happens with all kernels since 2.5.35 and it is random. It
> happens in xdm waiting for login, in starting up KDE, in starting up
> daemons at boot up.
> Even when hanging in X, the Alt-SysRq still works to SUB.
> 2.5.34+xfs (from the SGI CVS) works fine. I will try a recent snapshot
> from them, with a more recent kernel.
> florin

This is different for me. I'm seeing a false negative from
is_orphaned_pgrp().  I'm poking around for the race as I go,
though it isn't in is_orphaned_pgrp() itself.


Cheers,
Bill
