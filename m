Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWFRSgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWFRSgK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWFRSgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:36:09 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:22876 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751215AbWFRSgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:36:08 -0400
Date: Sun, 18 Jun 2006 11:36:06 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andr? Goddard Rosa <andre.goddard@gmail.com>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: Support for SEEK_HOLE and SEEK_DATA for sparse files on lseek(2)
Message-ID: <20060618183606.GA10859@tuatara.stupidest.org>
References: <b8bf37780606180620y6e980e04k5b35da2c61fa1d1f@mail.gmail.com> <20060618151411.GV27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618151411.GV27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 04:14:11PM +0100, Al Viro wrote:

> Well...  Description makes sense and it isn't hard to implement.
> About the only question is about semantics for directories...

Why not claim it's undefined for now and -EINVAL if someone tries to
use it?  We can relax that at a later stage is someone comes up with a
well-thought out alternative after some discussion.

