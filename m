Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263817AbUDTXq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbUDTXq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUDTXq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:46:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:41620 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263817AbUDTXqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:46:54 -0400
Date: Tue, 20 Apr 2004 16:41:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
Message-Id: <20040420164104.7fa61662.rddunlap@osdl.org>
In-Reply-To: <4085B2B9.6010007@bigfoot.com>
References: <40853060.2060508@bigfoot.com>
	<200404202326.24409.kim@holviala.com>
	<4085B2B9.6010007@bigfoot.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2004 16:31:05 -0700 Erik Steffl wrote:

| Kim Holviala wrote:
| > On Tuesday 20 April 2004 17:14, Erik Steffl wrote:
| > 
| > 
| >>   it looks that after update to 2.6.5 kernel (debian source package but
| >>I guess it would be the same with stock 2.6.5) the mouse wheel and side
| >>button on Logitech Cordless MouseMan Wheel mouse do not work.
| > 
| > 
| > Try my patch for 2.6.5: http://lkml.org/lkml/2004/4/20/10
| 
|    which part is patch? click on view this diff only and copy&paste that 
| and use it as a patch?

Don't copy&paste, just save that file to disk.

| 
| > Build psmouse into a module (for easier testing) and insert it with the proto 
| > parameter. I'd say "modprobe psmouse proto=exps" works for you, but you might 
| > want to try imps and ps2pp too. The reason I wrote the patch in the first 
| > place was that a lot of PS/2 Logitech mice refused to work (and yes, exps 
| > works for me and others)....


--
~Randy
"We have met the enemy and he is us."  -- Pogo (by Walt Kelly)
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
