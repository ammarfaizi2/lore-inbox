Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265945AbUAEVh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUAEVh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:37:56 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:3968 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265945AbUAEVhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:37:52 -0500
Date: Mon, 5 Jan 2004 13:37:37 -0800
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: [PATCH] Simplify node/zone field in page->flags
Message-ID: <20040105213736.GA19859@sgi.com>
Mail-Followup-To: Matthew Dobson <colpatch@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	mbligh@aracnet.com
References: <3FE74B43.7010407@us.ibm.com> <20031222131126.66bef9a2.akpm@osdl.org> <3FF9D5B1.3080609@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF9D5B1.3080609@us.ibm.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 01:22:57PM -0800, Matthew Dobson wrote:
> Jesse had acked the patch in an earlier itteration.  The only thing 
> that's changed is some line offsets whilst porting the patch forward.
> 
> Jesse (or anyone else?), any objections to this patch as a superset of 
> yours?

No objections here.  Of course, you'll have to rediff against the
current tree since that stuff has been merged for awhile now.  On a
somewhat related note, Martin mentioned that he'd like to get rid of
memblks.  I'm all for that too; they just seem to get in the way.

Jesse
