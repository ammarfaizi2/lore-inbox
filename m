Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbTB1Fkx>; Fri, 28 Feb 2003 00:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267481AbTB1Fkx>; Fri, 28 Feb 2003 00:40:53 -0500
Received: from [202.181.238.133] ([202.181.238.133]:10921 "EHLO debian.org.hk")
	by vger.kernel.org with ESMTP id <S267480AbTB1Fkw>;
	Fri, 28 Feb 2003 00:40:52 -0500
Message-ID: <3E5EF7A8.8050307@linux.org.hk>
Date: Fri, 28 Feb 2003 13:46:16 +0800
From: Ben Lau <benlau@linux.org.hk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Simon Oosthoek <simon@cal003100.student.utwente.nl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre5
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>	 <3E5DDCE7.2040100@linux.org.hk>	 <20030227101912.GA4006@margo.student.utwente.nl> <1046342924.27186.249.camel@zion.wanadoo.fr>
In-Reply-To: <1046342924.27186.249.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    Is there any simple method to trace which patch removed
the code?

I used the following command to check it..

grep define\ *hpsb_queue_struct\ *tq_struct patch-2.4.21-pre4-ac*

However, i have downloaded the patch from alan cox only...
it dont contain the code. any site have contained all the
patches that is -pre5 based on?

Benjamin Herrenschmidt wrote:
> On Thu, 2003-02-27 at 11:19, Simon Oosthoek wrote:
> 
> 
>>here's a patch that should work to fix this.
> 
> 
> I think the proper fix for now is to bring back all of
> ieee1394 from pre4 to pre5, it was an incorrect merge
> that reverted part of it.
> 
> Ben.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


