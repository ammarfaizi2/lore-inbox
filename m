Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUGNGoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUGNGoJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 02:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUGNGoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 02:44:09 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:26355 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267310AbUGNGoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 02:44:06 -0400
Date: Tue, 13 Jul 2004 23:44:00 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Roy Butler <roy.butler@jpl.nasa.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kconfig's file handling (was: XFS: how to NOT null files on fsck?)
Message-ID: <20040714064400.GA9721@taniwha.stupidest.org>
References: <40F4D266.4050006@jpl.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F4D266.4050006@jpl.nasa.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 11:27:50PM -0700, Roy Butler wrote:

> By example, if you create a file, write to it, and then delete it
> fast enough, it will never hit the disk under XFS.

Nor will it under some other filesystems...  and in the above scenario
I'm not sure that matters, why must a temporary file hit the disk at
all?


   --cw
