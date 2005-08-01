Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVHAPiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVHAPiq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVHAPip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:38:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30962 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262212AbVHAPhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:37:39 -0400
Subject: Re: 2.6.12.3 Oops
From: Daniel Walker <dwalker@mvista.com>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508011517.j71FHS6N010568@cichlid.com>
References: <200508011517.j71FHS6N010568@cichlid.com>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 08:36:35 -0700
Message-Id: <1122910596.5035.10.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 08:17 -0700, Andrew Burgess wrote:
> Stock 2.6.12.3 #2 Sun Jul 31 16:55:16 PDT 2005 i686 i686 i386 GNU/Linux
> 
> Seems to be triggered by mplayer but not right away (30 minutes sometimes), sometimes
> no mplayer is necessary.
> 
> This is a busy machine. There is continuous usb soundcard (3 soundcards) and
> usb ethernet activity (news server and alot of downloading) and video is being
> read continuously from the bt878 card.
> 
> Any suggestions for workarounds are greatly appreciated. I'm going to try running
> with swap off and see if that helps.

You might want to enable slab debugging. Here's how,

run "make menuconfig"
Select "Kernel hacking"

turn on "Kernel debugging"
and turn on "Debug memory allocations"

Daniel

