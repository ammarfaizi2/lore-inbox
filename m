Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVEZMdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVEZMdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVEZMdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:33:12 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:33235 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261352AbVEZMc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:32:56 -0400
Date: Thu, 26 May 2005 18:11:10 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset rmdir scheduling while atomic fix
Message-ID: <20050526124110.GB6496@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050526082516.927.6806.sendpatchset@tomahawk.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526082516.927.6806.sendpatchset@tomahawk.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 01:25:16AM -0700, Paul Jackson wrote:
> 
> The cpuset kernel code can generate a "scheduling while atomic"
> complaint from the cpuset_rmdir code.  This complaint means
> that we had to sleep while trying to get the cpuset_sem global
> semaphore during the handling of a 'rmdir()' call to remove
> a cpuset.
> 

Paul,  This was the same problem that I had reported earlier
and fixed as well

See, Message Id: fa.c883kus.qjgijs@ifi.uio.no on google groups

As far as I can see this has already been fixed and is in
2.6.12-rc5-mm1

	-Dinakar
