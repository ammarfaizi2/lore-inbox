Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbULUREU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbULUREU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbULUREU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:04:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:18575 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261806AbULURES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:04:18 -0500
Date: Tue, 21 Dec 2004 09:04:03 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Warren <SWarren@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Oops" in 2.6.9 SCSI w/ usb-storage & multi-LUN
Message-ID: <20041221170403.GA1459@kroah.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B003CE0CC2@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B003CE0CC2@hqemmail02.nvidia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 05:23:44PM -0800, Stephen Warren wrote:
> I've tried both test application under 2.6.10-rc3, and everything seems
> to work fine on that kernel. I see there were a lot of USB changes in
> 2.6.10.

2.6.10 isn't released yet :)

> Does anyone know what change from 2.6.10 fixed this specific issue. Is
> it something that's easy to isolate and back-port to 2.6.9?

Lots of different scsi and usb changes probably helped fix this.  I
suggest just going through the different patches and trying to narrow it
down if you really need to backport this.

Good luck,

greg k-h
