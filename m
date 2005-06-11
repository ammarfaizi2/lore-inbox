Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVFKSGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVFKSGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVFKSGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 14:06:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60043 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261767AbVFKSGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 14:06:14 -0400
Date: Sat, 11 Jun 2005 19:07:15 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Neil Horman <nhorman@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       matthew@wil.cx
Subject: Re: [Patch][RFC] fcntl: add ability to stop monitored processes
Message-ID: <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk>
References: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 08:05:48PM -0400, Neil Horman wrote:
> Hey there!
> 	I've recently developed this patch in pursuit of an ability to trap
> proceses making modifcations to monitored directories, and I thought It would be
> a nice feature to add to the mainline kernel.  It basically adds a flag to the
> F_NOTIFY fcntl which optionally sends a SIGSTOP to the process making the
> flagged modifications to the monitored directories, and passes the pid of the
> stopped process to the monitoring process.  I've tested it, and it works quite
> well for me.  Looking for comments/approvial/incorporation.

What stops me from setting a DN_STOPSND on /lib and preventing any new
tasks from starting up?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
