Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265626AbTFXCKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 22:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265627AbTFXCKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 22:10:36 -0400
Received: from smtp1.knology.net ([24.214.63.226]:63367 "HELO
	smtp1.knology.net") by vger.kernel.org with SMTP id S265626AbTFXCKg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 22:10:36 -0400
Subject: Re: 2.4.21 doesn't boot: /bin/insmod.old: file not found
From: John Shillinglaw <linuxtech@knology.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <23770.1056415063@firewall.ocs.com.au>
References: <23770.1056415063@firewall.ocs.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1056421483.3552.19.camel@Aragorn>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2003 22:24:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aha, Thanks, 

Is there a howto page yet that tells all about how the old and new
module utilities work? I'm sure it's right under my nose...

BTW, after vowing not to, I solved the problem by simply making ext3
part of bzImage.

Now I got back to 2.5.73...

Thanks again,
Ian
On Mon, 2003-06-23 at 20:37, Keith Owens wrote:

> initrd needs the static version of insmod.  Copy /sbin/insmod.static.old
> to the ramdisk and rename it as /bin/insmod.old to suit the 2.5 modutils.
> 


