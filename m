Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUAWNFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 08:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUAWNFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 08:05:34 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:65412 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S261190AbUAWNFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 08:05:30 -0500
Date: Fri, 23 Jan 2004 14:05:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: vts have stopped working here
Message-ID: <20040123130535.GA4046@ucw.cz>
References: <224300000.1074839500@[10.10.2.4]> <4010C2BF.7090806@cyberone.com.au> <200401230743.38488.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401230743.38488.edt@aei.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 07:43:38AM -0500, Ed Tomlinson wrote:

> Is anyone else having problems with vt(s)?  I can switch between X and vt 1 without
> problems.  Trying to use any of the other vt(s) fails.   
> 
> A+C+F1 flips from X to vt1
> A+F2 flips to vt7 (x)
> A+C+F2 from X does nothing
> 
> In my logs there are messages about init spawing too fast.  Suspect that these are
> the processes for the Vt(s) started with:
> 
> 2:23:respawn:/sbin/getty 38400 tty2

Interesting. The vt's don't exist until something writes to them. So
most likely X is running on vt2 in your case. As to why the processes
keep dying - no idea.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
