Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbTIKJiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 05:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbTIKJhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 05:37:07 -0400
Received: from mail.convergence.de ([212.84.236.4]:9137 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261182AbTIKJgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 05:36:54 -0400
Message-ID: <3F604230.5030207@convergence.de>
Date: Thu, 11 Sep 2003 11:36:48 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video/hexium_orion warning removal
References: <20030909160245.49e8bddd.shemminger@osdl.org>
In-Reply-To: <20030909160245.49e8bddd.shemminger@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

> The hexium_orion driver in 2.6.0-test5 gets a warning because it defines
> setup data that is never used.

Yes, I know. I did not have the time to hack on the Hexium Orion driver 
recently.

> Builds fine if it is deleted; don't have real hardware.

But I do. ;-) Please leave it in. I know it's an annoying warning, but 
the data will be useful once I've added real input selection support 
with proper usage of the setup data.

If this patch has already been applied, don't worry -- I'll resend this 
stuff then...

> diff -Nru a/drivers/media/video/hexium_orion.h b/drivers/media/video/hexium_orion.h
> --- a/drivers/media/video/hexium_orion.h	Tue Sep  9 15:56:54 2003
> +++ b/drivers/media/video/hexium_orion.h	Tue Sep  9 15:56:54 2003
[...]

CU
Michael.

