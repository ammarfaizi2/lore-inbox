Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUAOVGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAOVGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:06:43 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:29078 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261974AbUAOVF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:05:58 -0500
Date: Thu, 15 Jan 2004 22:05:55 +0100
From: Romain Lievin <romain@rlievin.dyndns.org>
To: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: True story: "gconfig" removed root folder...
Message-ID: <20040115210555.GA25072@rlievin.dyndns.org>
References: <1074177405.3131.10.camel@oebilgen>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1074177405.3131.10.camel@oebilgen>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 15, 2004 at 04:36:45PM +0200, Ozan Eren Bilgen wrote:
> Hi,
> 
> Today I downloaded 2.6.1 kernel and tried to configure it with "make
> gconfig". After all changes I selected "Save As" and clicked "/root"
> folder to save in. Then I clicked "OK", without giving a file name. I
> expected that it opens root folder and lists contents. But this magic
> configurator removed (rm -Rf) my root folder and created a file named
> "root". It was a terrible experience!..
> 

I attempted to reproduce your steps but it did not remove my /root directory.
Instead of that, gconf created a .config file in the root dir.

> Please fix this. I didn't check that same problem (I even didn't launch
> them) exist for other configurators then gconfig.
> 

Maybe I should avoid empty file name. It will be fixed in a further patch.

> I send this mail here because I guessed that the configurator is a part
> of kernel.
> 
> Note: (As you wished) Please CC me your responses.
> 
> 
> TIA
> -- 
> Comp. Eng. Ozan Eren BILGEN
> 
> TUBITAK - UEKAE (Turkey)
> National Research Institute of Electronics & Cryptology
> Special Projects Group
> Researcher
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Thanks, Romain.
-- 
Romain Li�vin (roms):         <roms@tilp.info>
Web site:                     http://tilp.info
"Linux, y'a moins bien mais c'est plus cher !"






