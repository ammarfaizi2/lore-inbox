Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTDPHre (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 03:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTDPHre 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 03:47:34 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:51411 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264255AbTDPHrd (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 03:47:33 -0400
Date: Wed, 16 Apr 2003 08:58:56 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030416075856.GC12031@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net> <20030415154355.08ef6672.akpm@digeo.com> <20030416004556.GD29143@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416004556.GD29143@iucha.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 07:45:56PM -0500, Florin Iucha wrote:

 > > Has anyone tried disabling kernel AGP support and retesting?
 > Now that you suggested it, I disabled kernel AGP support and 4.3.0
 > (Daniel Stone Debian packages) works fine so far.

Thing is, if this runs rock solid now, it's not necessarily indicative
of a bug in agpgart, it could equally be a bug in the DRM.
This disables a whole bunch of code, it's practically a completely
different application wrt 3d now.

Of course, if this _is_ a bug in agpgart, I'll be the first to put
my hands up.

		Dave

