Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbTC0VUX>; Thu, 27 Mar 2003 16:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbTC0VUX>; Thu, 27 Mar 2003 16:20:23 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:3809 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261376AbTC0VUW>;
	Thu, 27 Mar 2003 16:20:22 -0500
Date: Thu, 27 Mar 2003 15:31:31 -0600
From: Nathan Straz <nstraz@sgi.com>
To: Shaya Potter <spotter@yucs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: process creation/deletions hooks
Message-ID: <20030327213131.GA936@sgi.com>
Mail-Followup-To: Shaya Potter <spotter@yucs.org>,
	linux-kernel@vger.kernel.org
References: <1048799290.31010.62.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048799290.31010.62.camel@zaphod>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 04:08:10PM -0500, Shaya Potter wrote:
> We are trying to write a module that does it's own accounting of
> processes as they are created and deleted.  We have an extremely ugly
> hack of taking care of process creation (wrap fork() and clone() in a
> syscall wrapper, as that's the only way processes can be created).  

You might want to look at the PAGG patch.  SGI did something like this
to implement CSA, an accounting package.  Here are some links that might
interest you:

Linux PAGG home page:
http://oss.sgi.com/projects/pagg/

Design Doc:
http://oss.sgi.com/projects/pagg/pagg-lkd.txt

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
