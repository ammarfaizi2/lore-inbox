Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTJSTNx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTJSTNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:13:52 -0400
Received: from holomorphy.com ([66.224.33.161]:29570 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262069AbTJSTNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:13:51 -0400
Date: Sun, 19 Oct 2003 12:13:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Diego Calleja Garc?a <aradorlinux@yahoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproduceable oops in -test8
Message-ID: <20031019191346.GB1108@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Diego Calleja Garc?a <aradorlinux@yahoo.es>,
	linux-kernel@vger.kernel.org
References: <20031018234848.51a2b723.aradorlinux@yahoo.es> <20031019011949.GD711@holomorphy.com> <20031019165914.4360b3b7.aradorlinux@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019165914.4360b3b7.aradorlinux@yahoo.es>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 18 Oct 2003 18:19:49 -0700 William Lee Irwin III <wli@holomorphy.com> escribi?:
>> Two stupid bugs in my case. With a bit of noise surrounding things
>> (e.g. EXPORT_SYMBOL() crud, init_task paranoia garbage, ->f_pos in
>> unsigned long removal), un-reversing the arguments to find_pid()
>> and not blowing away the last-seen tid while formatting it and later
>> trying to use it as ->f_pos are the needed fixes.

On Sun, Oct 19, 2003 at 04:59:14PM +0200, Diego Calleja Garc?a wrote:
> This fixes the oops in wli1, thanks; now it reproduces the same behaviour
> of vanilla -test8

You say the behavior of vanilla 2.6.0-test8 was the machine and/or process
getting hung? And this is still happening even after the fixes?

Thing is, it's working perfectly here, though I don't have a decent way
to use totem. Could you send the results of sysrq t when it "hangs"?


-- wli
