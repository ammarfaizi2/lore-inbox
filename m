Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261695AbTCNKH0>; Fri, 14 Mar 2003 05:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbTCNKHZ>; Fri, 14 Mar 2003 05:07:25 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:23271 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261641AbTCNKHW>; Fri, 14 Mar 2003 05:07:22 -0500
Date: Fri, 14 Mar 2003 02:18:14 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dougg@torque.net,
       Mark Haverkamp <markh@osdl.org>,
       Christoffer Hall-Frederiksen <hall@jiffies.dk>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
Message-ID: <20030314101813.GA3458@beaverton.ibm.com>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, dougg@torque.net,
	Mark Haverkamp <markh@osdl.org>,
	Christoffer Hall-Frederiksen <hall@jiffies.dk>,
	linux-scsi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux aacraid devel <linux-aacraid-devel@dell.com>
References: <20030228133037.GB7473@jiffies.dk> <1047517604.23902.39.camel@irongate.swansea.linux.org.uk> <20030313005046.GB14373@beaverton.ibm.com> <200303140709.h2E79Ju06461@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303140709.h2E79Ju06461@Port.imtp.ilyichevsk.odessa.ua>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko [vda@port.imtp.ilyichevsk.odessa.ua] wrote:
> +       if(tags <= 0) {
> +                       printk(KERN_WARNING "(scsi%d:%d:%d:%d) "
> +                               "%s, tag value to small\n"
> +                               "disabled\n", SDpnt->host->host_no,
> 
> Please do not split message into several lines.
> There are several reasons why you shouldn't do it.

Thanks for pointing this out.

This was a paste typo. There was also some incorrect style spacing, and
it did not work (the queue_depth was set to tags down below).  From Doug
Ledford's later comments this change may not be needed to correct the
problem, but I will re-roll tomorrow.

-andmike
--
Michael Anderson
andmike@us.ibm.com

