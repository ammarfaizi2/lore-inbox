Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTJSVWI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 17:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJSVWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 17:22:08 -0400
Received: from holomorphy.com ([66.224.33.161]:59778 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262240AbTJSVWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 17:22:05 -0400
Date: Sun, 19 Oct 2003 14:21:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Diego Calleja Garc?a <aradorlinux@yahoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproduceable oops in -test8
Message-ID: <20031019212157.GD1215@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Diego Calleja Garc?a <aradorlinux@yahoo.es>,
	linux-kernel@vger.kernel.org
References: <20031018234848.51a2b723.aradorlinux@yahoo.es> <20031019011949.GD711@holomorphy.com> <20031019165914.4360b3b7.aradorlinux@yahoo.es> <20031019191346.GB1108@holomorphy.com> <20031019230751.5434e3fb.aradorlinux@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019230751.5434e3fb.aradorlinux@yahoo.es>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 19 Oct 2003 12:13:46 -0700 William Lee Irwin III <wli@holomorphy.com> escribi?:
>> You say the behavior of vanilla 2.6.0-test8 was the machine and/or process
>> getting hung? And this is still happening even after the fixes?

On Sun, Oct 19, 2003 at 11:07:51PM +0200, Diego Calleja Garc?a wrote:
> Yes.

El Sun, 19 Oct 2003 12:13:46 -0700 William Lee Irwin III <wli@holomorphy.com> escribi?:
>> Thing is, it's working perfectly here, though I don't have a decent way
>> to use totem. Could you send the results of sysrq t when it "hangs"?

On Sun, Oct 19, 2003 at 11:07:51PM +0200, Diego Calleja Garc?a wrote:
> Ok, I'll paste totem, esd, ps and xmms. xmms also hangs like totem; both of
> them are trying to play through esd (which is blocked, too). This is
> -test8-wli1 + fix.

I suspect a deadlock on pcm->open_mutex; I'm doing some more reading
around there to figure out what on earth is going on.


-- wli
