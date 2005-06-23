Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263197AbVFWIT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbVFWIT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVFWIJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:09:21 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:57281 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262286AbVFWGiT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:38:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZLIVcmOPmLw1sUzYy0sxhoS+Zmk9qIi5xA9jIphhEzoxAEYJ1H8NYUPuveyphyBfoiKZdbp4bfwW56lx9bQjQNRMruTogX2FlF2XjhisgWJQ3iYjKTxKBOVlPZeyUwwlxRIjzrO6R6nTr6Olq4SGMADO9FwPIaf8eGAa3N4JWZo=
Message-ID: <fc339e4a05062223385fa56c40@mail.gmail.com>
Date: Thu, 23 Jun 2005 15:38:19 +0900
From: Miles Bader <snogglethorpe@gmail.com>
Reply-To: snogglethorpe@gmail.com, miles@gnu.org
To: Mike Bell <kernel@mikebell.org>, Miles Bader <miles@gnu.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
In-Reply-To: <20050623063457.GB955@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050621062926.GB15062@kroah.com>
	 <20050620235403.45bf9613.akpm@osdl.org>
	 <20050621151019.GA19666@kroah.com>
	 <20050623010031.GB17453@mikebell.org>
	 <20050623045959.GB10386@kroah.com>
	 <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp>
	 <20050623063457.GB955@mikebell.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/05, Mike Bell <kernel@mikebell.org> wrote:
> Greg gave me an "I assume so" estimate that udev was smaller by excluding
> the size of sysfs a while back. If you include sysfs in udev's overhead
> then I believe devfs wins handily, but I haven't done the numbers to
> prove it so my estimate is no better. I'm just basing it on sysfs being
> absolutely huge, in linux-tiny terms.

Is it?  I always just sort of assumed that sysfs kernel support would
be more or less equivalent in size to devfs kernel support.

-Miles
-- 
Do not taunt Happy Fun Ball.
