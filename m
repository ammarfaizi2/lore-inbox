Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265302AbUFHT5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265302AbUFHT5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 15:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265310AbUFHT5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 15:57:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:29857 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265302AbUFHT5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 15:57:08 -0400
Date: Tue, 8 Jun 2004 09:09:07 -0700
From: Greg KH <greg@kroah.com>
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 026 release
Message-ID: <20040608160907.GA6471@kroah.com>
References: <20040607231440.GB11257@kroah.com> <20040608092154.GA28969@linux-ari.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608092154.GA28969@linux-ari.internal>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 11:21:54AM +0200, Alex Riesen wrote:
> There is a handle leak in failure path in file_map, and the result of
> file_map (or the result of the caller of the file_map) is not always
> checked.

Thanks for the patch, applied.

greg k-h
