Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTGGMyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 08:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266994AbTGGMyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 08:54:41 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:38786 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S264956AbTGGMyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 08:54:40 -0400
Date: Mon, 7 Jul 2003 15:09:05 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
Message-ID: <20030707130905.GA13611@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030703023714.55d13934.akpm@osdl.org> <200307060414.34827.phillips@arcor.de> <Pine.LNX.4.53.0307071042470.743@skynet> <200307071424.06393.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307071424.06393.phillips@arcor.de>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips, Mon, Jul 07, 2003 14:24:06 +0200:
> > Alternatively, how about using PAM to grant the CAP_SYS_NICE capability to
> > known interactive users that require it. Presumably the number of users
> > that require it is very small (in the case of the music player, only one)
> > so it wouldn't be a major security issue.
> 
> And set up distros to grant it by default.  Yes.
> 
> The problem I see is that it lets user space priorities invade the range of 
> priorities used by root processes.  What's really needed is a range of 
> negative priorities available to normal users that are not normally used by 
> root.
> 
> In retrospect, the idea of renicing all the applications but the
> realtime one  doesn't work, because it doesn't take care of
> applications started afterwards. 
> 

start login niced to -X ?

