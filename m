Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUFUDue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUFUDue (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 23:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUFUDud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 23:50:33 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:28049 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S264124AbUFUDu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 23:50:27 -0400
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.7-bk way too fast
Date: Sun, 20 Jun 2004 20:49:51 -0700
User-Agent: KMail/1.6.52
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <40D64DF7.5040601@pobox.com> <40D657B7.8040807@pobox.com>
In-Reply-To: <40D657B7.8040807@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406202049.51853.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, 

I believe it was already narrowed down by Hans-Frieder Vogt, see  
http://marc.theaimsgroup.com/?l=linux-kernel&m=108774225111967&w=2


Matt H.


On Sunday 20 June 2004 8:36 pm, Jeff Garzik wrote:
> Jeff Garzik wrote:
> > Something is definitely screwy with the latest -bk.  I updated from a
> > kernel ~1 week ago, and all timer-related stuff is moving at a vastly
> > increased rate.  My guess is twice as fast.  Most annoying is the system
> > clock advances at twice normal rate, and keyboard repeat is so sensitive
> > I am spending quite a bit of time typing this message, what with having
> > to delettte (<== example) extra characters.  Double-clicking is also
> > broken :(
>
> Looks like disabling CONFIG_ACPI fixes things.  Narrowing down cset now...
>
> 	Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
