Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbTAXQIT>; Fri, 24 Jan 2003 11:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267772AbTAXQIT>; Fri, 24 Jan 2003 11:08:19 -0500
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:24452 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S267771AbTAXQIS>; Fri, 24 Jan 2003 11:08:18 -0500
From: jlnance@unity.ncsu.edu
Date: Fri, 24 Jan 2003 11:17:29 -0500
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm5
Message-ID: <20030124161729.GA15945@ncsu.edu>
References: <20030123195044.47c51d39.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123195044.47c51d39.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 07:50:44PM -0800, Andrew Morton wrote:
>   So what anticipatory scheduling does is very simple: if an application
>   has performed a read, do *nothing at all* for a few milliseconds.  Just
>   return to userspace (or to the filesystem) in the expectation that the
>   application or filesystem will quickly submit another read which is
>   closeby.

Does this affect the faulting in of executable pages as well?

Thanks,

Jim
