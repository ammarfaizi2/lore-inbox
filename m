Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263794AbTKFVrt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTKFVrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:47:49 -0500
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:16263 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S263794AbTKFVrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:47:48 -0500
From: jlnance@unity.ncsu.edu
Date: Thu, 6 Nov 2003 16:47:46 -0500
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
Message-ID: <20031106214746.GA28517@ncsu.edu>
References: <BAY4-F41WYf5UPHvAo10001c90f@hotmail.com> <3FAA1056.6020003@aitel.hist.no> <20031106134031.GA2720@ncsu.edu> <1068128072.530.1421.camel@lemsip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068128072.530.1421.camel@lemsip>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 03:14:32PM +0100, Gianni Tedesco wrote:
> On Thu, 2003-11-06 at 14:40, jlnance@unity.ncsu.edu wrote:
> > If anyone has any ideas about this, I would love to hear them.
> 

> most likely it's copying a fsck load of that file in to anonymous
> mappings, causing swapping.

Thanks for the reply.  Unfortunatly thats not it.  I can reproduce this
problem with a little program that appends data to a file and every so
often seeks back to the beginning of the file and scribbles a little there.

Thanks,

Jim
