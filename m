Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275720AbRJAXuv>; Mon, 1 Oct 2001 19:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275727AbRJAXul>; Mon, 1 Oct 2001 19:50:41 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:25593
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S275720AbRJAXub>; Mon, 1 Oct 2001 19:50:31 -0400
Date: Mon, 1 Oct 2001 16:50:53 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing dmesg buffer size?
Message-ID: <20011001165053.A4836@mikef-linux.matchmail.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BB90039.E551000C@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB90039.E551000C@home.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2001 at 06:46:01PM -0500, Jordan Breeding wrote:
> What kernel parameter do I need to modify in the source to allow a
> larger dmesg buffer?  I have a lot of boot messages and I currently
> loose about 10-20 lines immediately and they can not even be seen in
> /var/log/dmesg because that file gets dumped after those lines are
> already gone.  Thanks to anyone who can help.
> 

Does dmesg wrap around before klogd can grab the info?  Check
/var/log/kern.log (in debian, your filename may vary...) to see...

Mike
