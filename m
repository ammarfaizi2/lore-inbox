Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUACVSk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUACVSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:18:39 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:38674 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264261AbUACVSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:18:38 -0500
Date: Sat, 3 Jan 2004 22:18:16 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040103211816.GD3728@alpha.home.local>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <1073161172.9851.260.camel@localhost> <200401040800.06529.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401040800.06529.kernel@kolivas.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

On Sun, Jan 04, 2004 at 08:00:06AM +1100, Con Kolivas wrote:
> There is a BASH bug that Linus noticed brought out by the more sensitive 
> timing in 2.6. The BASH developer has been informed it is there and it is 
> fixed in the latest version. Perhaps you're both seeing that. Check the lkml 
> archives.

I don't think it has anything to do with the bash bug, because it only
involved pipes creation. Bash creates no pipe when you simply launch
'ls -l' in an xterm.

It seems that I'll start some new compilations this evening just to refresh
my mind on this problem...

Cheers,
Willy

