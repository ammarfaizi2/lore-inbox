Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268975AbUHMFCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268975AbUHMFCI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 01:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268976AbUHMFCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 01:02:08 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:9335 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268975AbUHMFCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 01:02:06 -0400
Date: Fri, 13 Aug 2004 07:04:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benno <benjl@cse.unsw.edu.au>
Cc: Dan Aloni <da-x@colinux.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Generation of *.s files from *.S files in kbuild
Message-ID: <20040813050424.GA7417@mars.ravnborg.org>
Mail-Followup-To: Benno <benjl@cse.unsw.edu.au>,
	Dan Aloni <da-x@colinux.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040812192535.GA20953@callisto.yi.org> <20040813003743.GF30576@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813003743.GF30576@cse.unsw.edu.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 10:37:43AM +1000, Benno wrote:
> 
> The solution is fairly striaght forward -- just change the suffixes,
> the problem is exactly how to change them. I would propose changing it
> such that was stick with "vmlinux.lds.S" and have it generate "vmlinux.lds"
> 
> This would require the fewest changes to implement, just
> 1/ change %.s %.S rule to %.lds %.lds.S
> 2/ change the link flags from "-T vmlinux.lds.s" -> "-T vmlinux.lds"

I agree with this approach, and see no defencies.

Care to send two patches.
One that do what you suggest for i386, and another that cover the rest
of the architectures?

	Sam
