Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751873AbWIGXpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWIGXpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWIGXpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:45:17 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:61466 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S1751873AbWIGXpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:45:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAKNLAEWBTolx
From: Dmitry Torokhov <dtor@insightbb.com>
To: Darren Salt <linux@youmustbejoking.demon.co.uk>
Subject: Re: Touchpad sometimes detected twice
Date: Thu, 7 Sep 2006 19:45:13 -0400
User-Agent: KMail/1.9.3
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <4E623F81FD%linux@youmustbejoking.demon.co.uk> <200609062216.30904.dtor@insightbb.com> <4E62CC4533%linux@youmustbejoking.demon.co.uk>
In-Reply-To: <4E62CC4533%linux@youmustbejoking.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609071945.13418.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 September 2006 16:33, Darren Salt wrote:
> I demand that Dmitry Torokhov may or may not have written...
> 
> > On Wednesday 06 September 2006 14:56, Darren Salt wrote:
> >> Sometimes, the touchpad on my (new) laptop is detected twice. This can
> >> cause problems with udev: there may or may not be links in
> >> /dev/input/by-*, and if present, the links may be broken.
> 
> >> Config etc. attached.
> 
> > Hmm, you could try booting with i8042.nomux.
> 
> Now tried, and added to the boot command line; so far, the problem hasn't
> reappeared.
> 
> > Does this laptop have external PS/2 ports?
> 
> No.
> 

May I have the output of dmidecode utility so we can blacklist MUX mode
for that particular laptop please?

-- 
Dmitry
