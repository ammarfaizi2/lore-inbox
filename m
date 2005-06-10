Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVFJOTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVFJOTZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVFJOTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:19:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262544AbVFJOTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:19:20 -0400
Subject: Re: PROBLEM: Adaptec RAID 2010S hang-up under heavy load
From: Mark Haverkamp <markh@osdl.org>
To: Jan Marek <linux@hazard.jcu.cz>
Cc: Mark Salyzyn <mark_salyzyn@adaptec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050610123315.GB28099@hazard.jcu.cz>
References: <60807403EABEB443939A5A7AA8A7458B0147C0D5@otce2k01.adaptec.com>
	 <20050610122638.GA28099@hazard.jcu.cz>
	 <20050610123315.GB28099@hazard.jcu.cz>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 07:19:15 -0700
Message-Id: <1118413155.21188.0.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 14:33 +0200, Jan Marek wrote:
> Hello once more,
> 
> On Fri, Jun 10, 2005 at 02:26:38PM +0200, Jan Marek wrote:
> > Hello Mark,
> > 
> > On Thu, Jun 09, 2005 at 01:51:44PM -0400, Salyzyn, Mark wrote:
> > > The 2010S uses the dpt_i2o driver. You must be using a different aacraid
> > > based card. I can not determine which aacraid based card you are using
> > > from the logs. The 2120S perhaps? The 2120S is the single channel cousin
> > > of the 2200S and MarkH's advise should be taken (update to latest
> > > Firmware).
> > 
> > I'm very sorry about that: it's really 2200S. And it has firmware 6011
> > from asr2200s_fw_up_b6011.exe. Is somewhere a newest one?
> 
> I'm sorry, I have found firmware 7349. I will try it.

7349 is what I have running on my cards now and it has fixed the timeout
problems.

Good luck.

Mark.


-- 
Mark Haverkamp <markh@osdl.org>

