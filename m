Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269136AbUINCQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269136AbUINCQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUINCNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:13:45 -0400
Received: from holomorphy.com ([207.189.100.168]:62607 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269121AbUINCNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:13:09 -0400
Date: Mon, 13 Sep 2004 19:13:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, cw@f00f.org,
       mingo@elte.hu, anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040914021306.GJ9106@holomorphy.com>
References: <1095045628.1173.637.camel@cube> <20040913074230.GW2660@holomorphy.com> <1095084688.1173.1329.camel@cube> <20040913142752.GC9106@holomorphy.com> <20040913145148.GD1774@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913145148.GD1774@MAIL.13thfloor.at>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 07:27:52AM -0700, William Lee Irwin III wrote:
>> I'd suggest pushing for 64-bit+ pid's, then. IIRC most of the work
>> there is in userspace (the in-kernel part is trivial).

On Mon, Sep 13, 2004 at 04:51:48PM +0200, Herbert Poetzl wrote:
> except for the various 'assumptions' done in procfs
> to create the inode numbers ... but that is a different
> story ...

The overflow conditions in there are ugly and need someone willing to
do more intensive work with that code to address them. It's not
difficult per se, merely a lot of grubbing around with ugly code.


-- wli
