Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVLCVyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVLCVyl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVLCVyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:54:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:12774 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751284AbVLCVyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:54:40 -0500
Date: Sat, 3 Dec 2005 13:54:24 -0800
From: Greg KH <greg@kroah.com>
To: "M." <vo.sinh@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203215424.GA5444@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com> <20051203211209.GA4937@kroah.com> <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 10:31:03PM +0100, M. wrote:
> makes sense, but are you sure having distros like Debian, enterprise
> products from redhat etc using the same 6months release for their
> stable versions does not translate in minor fragmentation on kernel
> development and in benefits for every user?

It hasn't so far from my viewpoint.  Do you think it has?

> Under this light i think a 6months cycle starts to mean something when
> stable distros gets older and older (debian and redhat enterprise are
> released every 18/24 months) and developers and who wants bleeding
> edge features can always use Fedora, openSUSE, Gentoo etc. Another
> advantage would be to benefit external projects and hardware producers
> writing open drivers, enlowering the effort in writing and mantaining
> a driver.

Drivers belong in the main kernel.org kernel tree.  See
Documentation/stable-api-nonsense.txt for why this is so, and
Documentation/HOWTO for how to get this accomplished.  It is explained
in great detail there.  If you have further questions about this, please
let us know.

thanks,

greg k-h
