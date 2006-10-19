Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946353AbWJSSm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946353AbWJSSm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946354AbWJSSm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:42:56 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:62024 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1946353AbWJSSmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:42:55 -0400
Date: Thu, 19 Oct 2006 11:42:27 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061019184227.GZ2747@ca-server1.us.oracle.com>
Mail-Followup-To: Chandra Seetharaman <sekharan@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061011131935.448a8696.akpm@osdl.org> <20061011221822.GD7911@ca-server1.us.oracle.com> <20061011154836.9befa359.akpm@osdl.org> <1160609233.6389.82.camel@linuxchandra> <20061014080107.GB19325@kroah.com> <20061014124351.63434962.akpm@osdl.org> <20061014201016.GG2747@ca-server1.us.oracle.com> <1161026675.6389.128.camel@linuxchandra> <20061016230913.GN2747@ca-server1.us.oracle.com> <1161132928.5057.18.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161132928.5057.18.camel@linuxchandra>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 05:55:28PM -0700, Chandra Seetharaman wrote:
> On Mon, 2006-10-16 at 16:09 -0700, Joel Becker wrote:
> > 	Yes, if we provide a vector type in any way, it should be via
> > seq_operations or something like it.  If we're going to use seq_file, we
> > should use it correctly.
> > 
> 
> So, you want me to make a patch that uses seq_op instead of seq_file ? 
> I am willing to do it.

	I'd like to see a patch that enforces vectorization and nothing
else, if we were to do anything.

Joel


-- 

"When arrows don't penetrate, see...
 Cupid grabs the pistol."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
