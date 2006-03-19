Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWCSDw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWCSDw5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 22:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWCSDw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 22:52:57 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:14235 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751291AbWCSDw4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 22:52:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qIDeCDz0SXjK/jYIgT2I205Dh06+ztv9+LhIiyPy9t5eKLUq8Pvhk+/E5eHyuc+yKoRCfBfvjrYphcNs7aI271CB4Pu8GcPAlzhKFyFw2VNNggu40zT+5z4id6XBzjyFVu5ktRtj6JB6nV8jmuF7hYDWqN5IOo53SKVH4QSKHN0=
Message-ID: <72dbd3150603181952g46a374b2k66070f6730c30c50@mail.gmail.com>
Date: Sat, 18 Mar 2006 19:52:53 -0800
From: "David Rees" <drees76@gmail.com>
To: "Dave Johnson" <dave-linux-kernel@centerclick.org>
Subject: Re: 3ware 6x00 monitor/control utilities broken/dropped since 2.6.10?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17435.43034.364906.429948@wellington.i202.centerclick.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17435.43034.364906.429948@wellington.i202.centerclick.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/06, Dave Johnson <dave-linux-kernel@centerclick.org> wrote:
> The problem is I'm already using the latest 3ware utilities (v6.9 for
> the 6400).  While the driver does allow access to the array from the
> SCSI subsystem and I can use the filesystem, I have no way to monitor
> or control it anymore.

I've got the same problem with a number of 6xxx 3ware cards I've got.

I wish there was a simple way to monitor the raid status in /proc
without having to use their 3dm tools. You can monitor
/var/log/messages for 3ware errors, but then you'll still have to
reboot to get into the 3ware bios to do any maintenance.

-Dave
