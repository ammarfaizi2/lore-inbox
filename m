Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWIGCQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWIGCQe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 22:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWIGCQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 22:16:34 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:27546 "EHLO
	asav14.insightbb.com") by vger.kernel.org with ESMTP
	id S1422648AbWIGCQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 22:16:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAE4d/0SBT4lwLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Darren Salt <linux@youmustbejoking.demon.co.uk>
Subject: Re: Touchpad sometimes detected twice
Date: Wed, 6 Sep 2006 22:16:30 -0400
User-Agent: KMail/1.9.3
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <4E623F81FD%linux@youmustbejoking.demon.co.uk>
In-Reply-To: <4E623F81FD%linux@youmustbejoking.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609062216.30904.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 September 2006 14:56, Darren Salt wrote:
> Sometimes, the touchpad on my (new) laptop is detected twice. This can cause
> problems with udev: there may or may not be links in /dev/input/by-*, and if
> present, the links may be broken.
> 
> Config etc. attached.
> 

Hmm, you could try booting with i8042.nomux. Does this laptop have external
PS/2 ports?

-- 
Dmitry
