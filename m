Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268904AbUJKNNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268904AbUJKNNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJKNNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:13:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48774 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268904AbUJKNNv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:13:51 -0400
Date: Mon, 11 Oct 2004 14:13:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ricky lloyd <ricky.lloyd@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]:2.6.9-rc4: Fixes a bunch of compiler warnings
Message-ID: <20041011131350.GT23987@parcelfarce.linux.theplanet.co.uk>
References: <1a50bd370410110405253e915c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a50bd370410110405253e915c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 04:35:49PM +0530, Ricky lloyd wrote:
> attaching a patch diff'ed against 2.6.9-rc4. Fixes a whole bunch of
> compiler warnings of the
> kind, "warning: passing arg 1 of `readl' makes pointer from integer
> without a cast"

Don't.  You are just hiding the real problems that way.
