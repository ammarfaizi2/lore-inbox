Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751729AbWJAN5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbWJAN5B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 09:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWJAN5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 09:57:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32172 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751729AbWJAN5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 09:57:01 -0400
Date: Sun, 1 Oct 2006 14:56:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Announce: gcc bogus warning repository
Message-ID: <20061001135658.GU29920@ftp.linux.org.uk>
References: <451FC657.6090603@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451FC657.6090603@garzik.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 09:44:55AM -0400, Jeff Garzik wrote:
> This repository will NEVER EVER be pushed upstream.  It exists solely 
> for those who want to decrease their build noise, thereby exposing true 
> bugs.

Another way to deal with that is to use remap-log...  See
git://git.kernel.org/pub/scm/linux/kernel/git/viro/remapper.git/
for current version; it's _very_ good at reducing noise in diffs
from line renumbering, leaving the real changes.  While the number
of bogus warnings is very high, indeed, the rate at which they
appear is not _that_ horrible...
