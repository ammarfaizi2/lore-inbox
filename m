Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbUEHOug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUEHOug (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 10:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUEHOug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 10:50:36 -0400
Received: from d61.wireless.hilander.com ([216.241.32.61]:19607 "EHLO
	ramirez.hilander.com") by vger.kernel.org with ESMTP
	id S263169AbUEHOue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 10:50:34 -0400
Date: Sat, 08 May 2004 08:50:33 -0600
From: "Alec H. Peterson" <ahp@hilander.com>
To: s0348365@sms.ed.ac.uk
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI memory reservation failure - 2.4/2.6
Message-ID: <9DAA2DCC4D2B8938ACBD34A8@[192.168.0.100]>
In-Reply-To: <200405081542.39712.s0348365@sms.ed.ac.uk>
References: <040140D264E9D0D3189D4843@[192.168.0.100]>
 <200405081542.39712.s0348365@sms.ed.ac.uk>
X-Mailer: Mulberry/3.1.3 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Spam-Score: 1.1 (+)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, May 8, 2004 3:42 PM +0100 Alistair John Strachan 
<s0348365@sms.ed.ac.uk> wrote:

>
> If it's of any help to you, please see my recent bugzilla posting and
> mail to  the linux-pcmcia list. I believe we have the same problem. I
> have had  problems with PCI allocations on this nForce 2 (for example,
> lots of hardware  that somehow works in Linux does not work in The Other
> OS, the PCMCIA bridge  is no exception).

I don't think that patch will work, and here is why (at least in my case). 
There they are using 4k alignment, but unfortunately I already tried that 
and it required that the memory be aligned on its allocation size.

Could you try my patch instead of the one described in the bug report and 
see if it works?

Thanks!

Alec

