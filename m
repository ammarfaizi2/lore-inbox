Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSLMRgC>; Fri, 13 Dec 2002 12:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbSLMRgC>; Fri, 13 Dec 2002 12:36:02 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:51213 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S265187AbSLMRgB>; Fri, 13 Dec 2002 12:36:01 -0500
Date: Fri, 13 Dec 2002 17:43:55 +0000
To: Greg KH <greg@kroah.com>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>, lvm-devel@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: dmfs for 2.5.51
Message-ID: <20021213174355.GA21887@reti>
References: <20021213012618.GH23509@kroah.com> <20021213093745.GB1117@reti> <20021213172956.GB27800@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021213172956.GB27800@kroah.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 09:29:56AM -0800, Greg KH wrote:
> The latest for Red Hat 7.2: gcc-2.96-112.7.2
> Are you using 3.2?

gcc version 2.95.4 20011002 (Debian prerelease)

> > The files can be larger than a single page, which complicates things
> > somewhat.
> 
> Hm, then using the seq_file interface might be easier.  I'll look into
> this.

Remember that the table file needs to hold two files at times: the new
table that is being read in and the old table in case the new table is
invalid.

- Joe
