Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWEaVFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWEaVFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWEaVFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:05:36 -0400
Received: from gw.goop.org ([64.81.55.164]:23485 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965000AbWEaVFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:05:35 -0400
Message-ID: <447E03B8.7010806@goop.org>
Date: Wed, 31 May 2006 13:59:36 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC] maxSize option for usb-serial to increase max endpoint
 buffer size
References: <447DFBC5.70200@goop.org> <20060531203803.GA7735@suse.de>
In-Reply-To: <20060531203803.GA7735@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Not correct or needed at all.  What needs to happen is the airprime
> driver should be changed to handle bigger buffer sizes in it, not to
> mess with the usb-serial core.
>   
Yes, that sounds much more sensible.

> I've been working with Ken on getting this driver to work better
> (meaning faster).  Here's the latest version (without your new device id
> added).  Care to test it out and let me know if it works or not?
>   
Looks good so far.

    J

