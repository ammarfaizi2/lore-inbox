Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbUKSUFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbUKSUFK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUKSUDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 15:03:07 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:47346 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261574AbUKSUCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 15:02:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fpZqIJvR3LQa1DhjIH80+WlAB/7zIqzWRaNOVQ3iuG9kfF6aKBtXKBDb8a+NJMq0Si8Sf9KCQWeZd4iJ1N7i3FTqXHp2WTTIT9n7bOfJWlUewSnI3mFL9sxlsxoNhUPbBTnUsxHGtnVjQ+TLTUv7swkxuQEhwOQxi5varvqi9bE=
Message-ID: <58cb370e04111912026b189bc8@mail.gmail.com>
Date: Fri, 19 Nov 2004 21:02:38 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: IDE ioctl documentation & a new ioctl
Cc: Edward Falk <efalk@google.com>, linux-kernel@vger.kernel.org
In-Reply-To: <419D719B.1090408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <419D5CE6.8030503@google.com> <419D719B.1090408@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Documenting existing ioctls would be appreciated by many people...

On Thu, 18 Nov 2004 23:07:55 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Edward Falk wrote:
> > And while I'm on the subject, we're getting ready to write a new hdio
> > ioctl, an extension of HDIO_DRIVE_CMD.  The intent here is to be
> > slightly more general-purpose than HDIO_DRIVE_CMD, with an eye to
> > supporting the full set of SMART functionality.  Current plan is to have
> > the user pass a struct containing a pointer to the argument list, a
> > pointer to the data buffer, and a data buffer length value.  Consider
> > this a design document; any comments and/or feature requests?
> 
> HDIO_DRIVE_TASK and flagged taskfiles should cover everything you need.

HDIO_DRIVE_TASKFILE for (flagged) taskfiles and commands requiring
data transfers.

Bartlomiej
