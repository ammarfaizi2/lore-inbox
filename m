Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbTC0KuI>; Thu, 27 Mar 2003 05:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261922AbTC0KuI>; Thu, 27 Mar 2003 05:50:08 -0500
Received: from [213.196.40.44] ([213.196.40.44]:46728 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S261916AbTC0KuI>;
	Thu, 27 Mar 2003 05:50:08 -0500
Date: Thu, 27 Mar 2003 11:45:18 +0100 (CET)
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: Meelis Roos <mroos@linux.ee>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre6
In-Reply-To: <E18yVqr-0004gQ-00@roos.tartu-labor>
Message-ID: <Pine.LNX.4.33.0303271144400.27475-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Meelis Roos wrote:

> MT> Here goes -pre6.
> MT> 
> MT> We are approaching -rc stage. I plan to release -pre7 shortly which should
> MT> fixup the remaining IDE problems (thanks Alan!) and -rc1 later on.
> 
> HDLC started generating warnings in some -pre and they are still there:
> 
> /oma/compile/linux-2.4/include/linux/modules/hdlc.ver:3: warning: `__ver_register_hdlc_device' redefined
> /oma/compile/linux-2.4/include/linux/modules/hdlc_generic.ver:3: warning: this is the location of the previous definition
> /oma/compile/linux-2.4/include/linux/modules/hdlc.ver:5: warning: `__ver_unregister_hdlc_device' redefined
> /oma/compile/linux-2.4/include/linux/modules/hdlc_generic.ver:5: warning: this is the location of the previous definition

Try copying .config away, make mrproper, then the normal routine.
That should fix things for you.

Regards,

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

