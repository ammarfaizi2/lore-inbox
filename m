Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262145AbTCHSyc>; Sat, 8 Mar 2003 13:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbTCHSyb>; Sat, 8 Mar 2003 13:54:31 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:34987 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S262145AbTCHSyb>; Sat, 8 Mar 2003 13:54:31 -0500
Message-ID: <3E69CEF9.9050808@myrealbox.com>
Date: Sat, 08 Mar 2003 11:07:37 +0000
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre5-ac2:  kernel oops with "swapoff -a"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

When I do "swapoff -a" I still see the kernel oops that began with -pre4-ac7
and has propagated to every 'ac' kernel since then.

It's a "null-pointer dereference" oops which does not crash the system --
I still don't understand how that is possible.

Am I really the only person having this problem?  The oops is 100% reproducible
so it's hard to believe no one else is seeing it.  It happens on all three of
the machines I try it on, so it doesn't seem to be hardware-specific.

Plain 2.4.21-pre5 does NOT show this problem, so it seems to be a patch that
was specifically introduced in -pre4-ac7 and I don't know enough to narrow
it any further than that.  I'm not an accomplished kernel debugger so I
can't offer much more info than that, but I'd like to help if you can give
me some hints what kind of information you might need to find the problem.

