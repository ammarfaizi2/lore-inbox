Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWCCTwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWCCTwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 14:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWCCTwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 14:52:36 -0500
Received: from guru.webcon.ca ([216.194.67.26]:34282 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S1751381AbWCCTwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 14:52:36 -0500
Date: Fri, 3 Mar 2006 14:52:33 -0500 (EST)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Setkeycodes w/ keycode >= 0x100 ?
In-Reply-To: <Pine.LNX.4.61.0603031418530.4130@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0603031448170.26582@light.int.webcon.net>
References: <Pine.LNX.4.64.0603031241130.15776@light.int.webcon.net>
 <Pine.LNX.4.61.0603031322410.18198@chaos.analogic.com>
 <Pine.LNX.4.64.0603031343270.15776@light.int.webcon.net>
 <Pine.LNX.4.61.0603031418530.4130@chaos.analogic.com>
Organization: Webcon, Inc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Assp-Spam-Prob: 0.00000
X-Assp-Whitelisted: Yes
X-Assp-Envelope-From: imorgan@webcon.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2006, linux-os (Dick Johnson) wrote:

> Well the input.h in the distribution I use, has the highest key-code
> as KEY_UNKNOWN and that is number 200. Perhaps you are trying to
> use BTN_0 through BTN_N as key codes? Or perhaps there is some
> unfinished business in your version of headers?

Irrespective of distro, recent kernel (2.6.15.5) headers have KEY_MAX as
0x1ff (511). Incidentally, my glibc headers have the same thing.

You must have very old headers, as here KEY_PLAYCD=200, KEY_UNKNOWN=240, and
KEY_MAX=0x1ff.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
    *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------
