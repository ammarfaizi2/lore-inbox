Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUHMNMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUHMNMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 09:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUHMNMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 09:12:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20162 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265247AbUHMNMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 09:12:54 -0400
Date: Fri, 13 Aug 2004 14:12:53 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ben Castricum <lk@bencastricum.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc doesn't detect USB modem/weird SSH problem
Message-ID: <20040813131253.GV12308@parcelfarce.linux.theplanet.co.uk>
References: <001d01c48135$a0741b30$0502a8c0@tragebak>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01c48135$a0741b30$0502a8c0@tragebak>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 02:59:32PM +0200, Ben Castricum wrote:
> The SSH problem is a bit stranger. I know this is a user space application
> but since 2.6.7 has no problems I thought I mention it just in case. If I
> strace the daemon and compare a working with a non-working session the
> non-working sessions fails on this:
> open("/dev/ptmx", O_RDWR)         = -1 EIO (Input/output error)
> 
> Any suggestions?

For ssh - see ftp.linux.org.uk/pub/people/viro/ptmx-delta.  USB - fsck knows.
