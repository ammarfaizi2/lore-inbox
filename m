Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbUKIUcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUKIUcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUKIUcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:32:39 -0500
Received: from 80.178.47.123.forward.012.net.il ([80.178.47.123]:15744 "EHLO
	linux15") by vger.kernel.org with ESMTP id S261658AbUKIUcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:32:25 -0500
From: Oded Shimon <ods15@ods15.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: RivaFB on Geforce FX 5200
Date: Tue, 9 Nov 2004 22:32:24 +0200
User-Agent: KMail/1.7
References: <200411091458.06585.ods15@ods15.dyndns.org> <Pine.LNX.4.61.0411092106150.2007@cube.lan>
In-Reply-To: <Pine.LNX.4.61.0411092106150.2007@cube.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-8-i"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411092232.24615.ods15@ods15.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 November 2004 22:11, Janusz Dziemidowicz wrote:
> I assume You are trying to use rivafb with nvidia binary drivers? If
> that's the case, then here's an excerpt from NVIDIA README file:
Nope, during all my rivafb "development", X was either off or on using module 
'nv', which so far is co-operating very well with rivafb.

When I first had trouble modprobing rivafb, and it wasn't finding the device, 
I figured it was cause of "nvidia".. later realized it was because of 
"vesafb", oh well....

Anyway, I got rivafb to actually work pretty well, most of the problems were 
solved with a small modification made from the X nv source, and now only 
these problems are left:

1. When switching from X back to console, there's still the ugly X cache 
visible, to fix all what is needed is a ^L or switch to tty2 and back (ie, 
"refresh" the screen)... not a serious issue, but a little annoying.
2. Still no boot up penguin. :(   Strangely, the black bar where its supposed 
to be still exist... I'm clueless.

Since those are the only 2 problems left, I am now preparing a patch to send 
here... stay tuned...

- ods15
