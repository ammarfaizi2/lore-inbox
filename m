Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbUDQTlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbUDQTlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:41:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51929 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264028AbUDQTlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:41:03 -0400
Date: Sat, 17 Apr 2004 21:40:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "C.L. Tien - ??????" <cltien@cmedia.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: cmpci 6.82 released
Message-ID: <20040417194055.GJ14212@fs.tum.de>
References: <92C0412E07F63549B2A2F2345D3DB515F7D438@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D438@cm-msg-02.cmedia.com.tw>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 09:52:27AM +0800, C.L. Tien - ?????? wrote:

> Did you mean __devinit should be __devexit for cm_remove? Indeed, when I first change it, this question rose. There are still many other driver in kernel 2.4.25 use the same way. But I checked the driver in kernel 2.6 tree use the __devexit already for correct semantic meaning. I made following change, thanks for your correction.
>...

Yes.

After a quick look over the patches, it seems this was the only problem 
regarding __{,dev}{init,exit}.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

