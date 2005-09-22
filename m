Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVIVGhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVIVGhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVIVGht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:37:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750933AbVIVGhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:37:48 -0400
Date: Wed, 21 Sep 2005 23:37:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove check_region from PnPWakeUp routine of Eepro ISA
 driver
Message-Id: <20050921233708.553c9d2f.akpm@osdl.org>
In-Reply-To: <20050922062943.GA31805@gollum.tnic>
References: <20050922060030.GB19049@gollum.tnic>
	<20050921230915.364f0ac9.akpm@osdl.org>
	<20050922062943.GA31805@gollum.tnic>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <petkov@uni-muenster.de> wrote:
>
> > That being said, the code you've modified is disabled due to
>  > !defined(PnPWakeup), and the chances of anyone ever changing that are close
>  > to zero.
>  should I remove it then altogether?

We might as well leave it there in case someone is inspired to reenable the
feature and work on the driver a bit.  The chances of that are near zero -
it's ancient.  I don't think there's much point in spending time on this
driver.
