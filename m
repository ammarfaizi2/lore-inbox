Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbTCMXOp>; Thu, 13 Mar 2003 18:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbTCMXOi>; Thu, 13 Mar 2003 18:14:38 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11941 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262609AbTCMXOe>; Thu, 13 Mar 2003 18:14:34 -0500
Message-ID: <3E71134F.5060404@redhat.com>
Date: Thu, 13 Mar 2003 18:25:03 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Haverkamp <markh@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, dougg@torque.net,
       Christoffer Hall-Frederiksen <hall@jiffies.dk>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
References: <20030228133037.GB7473@jiffies.dk>	 <1047510381.12193.28.camel@markh1.pdx.osdl.net>	 <1047514681.23725.35.camel@irongate.swansea.linux.org.uk>	 <3E6FC8D6.7090005@torque.net>	 <1047517604.23902.39.camel@irongate.swansea.linux.org.uk>	 <1047570132.30105.7.camel@markh1.pdx.osdl.net>	 <3E711194.9010505@redhat.com> <1047597729.30103.386.camel@markh1.pdx.osdl.net>
In-Reply-To: <1047597729.30103.386.camel@markh1.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Haverkamp wrote:
> Then it sounds like the aacraid driver could set cmd_per_lun to a small
> number like one since the real queue depth will be set later in
> aac_slave_configure.

Yes.  And since the driver doesn't support anything other than drives to 
my knowledge, 1 would be appropriate.


-- 
   Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
          Red Hat, Inc.
          1801 Varsity Dr.
          Raleigh, NC 27606


