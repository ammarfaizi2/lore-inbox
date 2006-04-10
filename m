Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWDJWcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWDJWcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWDJWcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:32:13 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:29965 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932108AbWDJWcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:32:13 -0400
Date: Tue, 11 Apr 2006 00:32:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc] [PATCH] kbuild: rebuild initramfs if included files changes
Message-ID: <20060410223209.GA16842@mars.ravnborg.org>
References: <20060409205920.GA22482@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060409205920.GA22482@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 10:59:20PM +0200, Sam Ravnborg wrote:
> This fix has been implemented in preparation for the upcoming klibc
> merge in -mm. But as it fixes a real (but rare I hope) bug in vanilla
> kernel it will be added to my pending 2.6.17 kbuild queue.
> 
> I've done quite some changes to the gen_initramfs script and
> being shell programming newbie review by more experienced shell
> hackers would be appreciated.
> 
> I did a git mv scripts/gen_initramfs_list.sh usr/gen_initramfs.sh
> But the changes was so many that git does not see the rename.
> Due to the rename the diffstat shows a bit mroe changes than reality.

This patch turned out to be bogus.
I have something new in the works - will be finished tomorrow.

I will delete this commit from kbuild.git before posting the corrected
version.

	Sam
