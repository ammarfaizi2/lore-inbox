Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVDOJpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVDOJpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 05:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVDOJpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 05:45:04 -0400
Received: from hermes.domdv.de ([193.102.202.1]:60175 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261789AbVDOJol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 05:44:41 -0400
Message-ID: <425F8CEB.9010806@domdv.de>
Date: Fri, 15 Apr 2005 11:44:11 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andy Isaacson <adi@hexapodia.org>, Stefan Seyfried <seife@suse.de>,
       Herbert Xu <herbert@gondor.apana.org.au>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl> <20050414171127.GL3174@waste.org> <425EC41A.4020307@suse.de> <20050414195352.GM3174@waste.org> <20050414221153.GE27881@hexapodia.org> <20050414224846.GQ3174@waste.org>
In-Reply-To: <20050414224846.GQ3174@waste.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> A much more likely vector is stealing the laptop while it's suspended.
> And the encrypted swsusp patch has -zero- security here: it writes the
> key in the header in the clear. It's rather odd that everyone's hung
> up on the "box rooted after resume" attack and completely ignoring the
> much more common "stole my laptop" attack.
> 

Thats because you have already have a solution for "stolen while
suspended" with dm-crypt and initrd/initramfs but you don't have a
solution for "rooted after resume".
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
