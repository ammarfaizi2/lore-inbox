Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTLDTAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTLDTAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:00:04 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:7954 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263561AbTLDTAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:00:01 -0500
Date: Thu, 4 Dec 2003 10:59:36 -0800
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: memory hotremove prototype, take 3
Message-ID: <20031204185936.GB7965@sgi.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031201034155.11B387007A@sv1.valinux.co.jp> <187360000.1070480461@flay> <20031204035842.72C9A7007A@sv1.valinux.co.jp> <152440000.1070516333@10.10.2.4> <20031204154406.7FC587007A@sv1.valinux.co.jp> <20031204182729.GA7965@sgi.com> <14880000.1070562593@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14880000.1070562593@flay>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 10:29:53AM -0800, Martin J. Bligh wrote:
> >> IIRC, memory is contiguous within a NUMA node.  I think Goto-san will
> >> clarify this issue when his code gets ready. :-)
> > 
> > Not on all systems.  On sn2 we use ia64's virtual memmap to make memory
> > within a node appear contiguous, even though it may not be.
> 
> Wasn't there a plan to get rid of that though? I forget what it was,
> probably using CONFIG_NONLINEAR too ... ?

I think config_nonliner would do the trick, but no one's done the work
yet :)

Jesse
