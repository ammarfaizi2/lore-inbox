Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTDEQTv (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 11:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbTDEQTv (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 11:19:51 -0500
Received: from main.gmane.org ([80.91.224.249]:28092 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262515AbTDEQTu (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 11:19:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: Linux 2.5.66-ac2
Date: Sat, 05 Apr 2003 11:28:13 -0500
Message-ID: <3E8F041D.5020706@myrealbox.com>
References: <200304041959.h34JxXE25668@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This is mostly a resync and check patch rather than something
> exciting to run. It should work but it is not at all tested.
> The SMP crash on boot should be fixed too
> 
Alan,

It appears, at least to me, that you've got some duplicate 
code in timer_cyclone.c.  It seems that you should be 
replacing the current init cpu_khz with the new one in your 
patch (except your patch has the new one duplicated as 
well).  Just thought you should know....

Cheers,
Nicholas


