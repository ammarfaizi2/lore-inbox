Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVACSj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVACSj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVACSf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:35:58 -0500
Received: from dhcp93115068.columbus.rr.com ([24.93.115.68]:6411 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261775AbVACSbk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:31:40 -0500
Date: Mon, 3 Jan 2005 13:31:34 -0500
From: Joseph Fannin <jhf@rivenstone.net>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.sf.net
Subject: Re: [XEN] using shmfs for swapspace
Message-ID: <20050103183133.GA19081@samarkand.rivenstone.net>
Mail-Followup-To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
	linux-kernel@vger.kernel.org, xen-devel@lists.sf.net
References: <20050102162652.GA12268@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20050102162652.GA12268@lkcl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 04:26:52PM +0000, Luke Kenneth Casson Leighton wrote:
[...] 
> this is presumed to be infinitely better than forcing the swapspace to
> be always on disk, especially with the guests only being allocated
> 32mbyte of physical RAM.

    I'd be interested in knowing how a tmpfs that's gone far into swap
performs compared to a more normal on-disk fs.  I don't know if anyone
has ever looked into it.  Is it comparable, or is tmpfs's ability to
swap more a last-resort escape hatch?

    This is the part where I would add something valuable to this
conversation, if I were going to do that. (But no.)
-- 
Joseph Fannin
jhf@rivenstone.net  
