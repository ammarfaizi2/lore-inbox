Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVCJQWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVCJQWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVCJQWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:22:51 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:26800 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262706AbVCJQSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:18:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=W0QHDHCe2PhhC8lE+gp5EH/RDOQTmLonRBGZ0v3vEDOyHac9szK2+nDDdZfQpElXgvkJ2yNG3auFZO3zbjh+WJHkekB7wYymdbFTgq25bwxFjJEy7IBPuf8OUJWfPYDxMBLA4b0bTbctw7Z0NdgS8NxsulcWWGeAyEiqZ9aJUTA=
Message-ID: <9e4733910503100818df5fb2@mail.gmail.com>
Date: Thu, 10 Mar 2005 11:18:38 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: current linus bk, error mounting root
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310160155.GC2578@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422F5D0E.7020004@pobox.com> <20050309210926.GZ28855@suse.de>
	 <9e473391050309171643733a12@mail.gmail.com>
	 <20050310075049.GA30243@suse.de>
	 <9e4733910503100658ff440e3@mail.gmail.com>
	 <20050310153151.GY2578@suse.de>
	 <9e473391050310074556aad6b0@mail.gmail.com>
	 <20050310154830.GB2578@suse.de>
	 <9e47339105031007595b1e0cc3@mail.gmail.com>
	 <20050310160155.GC2578@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 17:01:55 +0100, Jens Axboe <axboe@suse.de> wrote:
> what are the major/minor numbers of /dev/root?


If I boot on a working system it is 8,5

mkrootdev is a nash command

       mkrootdev path
              Makes path a block inode for the device which should be mounted
              as  root.  To  determine  this device nash uses the device sug-
              gested by the root= kernel command line argument (if root=LABEL
              is  used devices are probed to find one with that label). If no
              root=  argument  is  available,  /proc/sys/kernel/real-root-dev
              provides the device number.


I already tried switching from the label syntax to /dev/sda5 without effect.

-- 
Jon Smirl
jonsmirl@gmail.com
