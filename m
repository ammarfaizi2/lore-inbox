Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbUCJVIl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUCJVBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:01:25 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:28258 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262839AbUCJVBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:01:11 -0500
Date: Wed, 10 Mar 2004 13:01:04 -0800
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040310210104.GA10406@sgi.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040310115545.16cb387f.akpm@osdl.org> <200403102003.i2AK3qm16576@unix-os.sc.intel.com> <20040310202025.GH15087@suse.de> <20040310204532.GA10281@sgi.com> <20040310204936.GJ15087@suse.de> <20040310205237.GK15087@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310205237.GK15087@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 09:52:37PM +0100, Jens Axboe wrote:
> And what fs, if any? The XFS changes probably need someone knowledgable
> about XFS internals to verify them.

Yeah, sorry.  I forgot to post CPU time info too (I'm putting that
together now).  The benchmark is doing small, direct I/O requests
directly to the block devices (e.g. /dev/sdd1).

Jesse
