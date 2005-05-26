Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVEZOfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVEZOfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 10:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVEZOfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 10:35:36 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:23866 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261502AbVEZOf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 10:35:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=H9bHLuHIvzN8XZLa1lm5WH8lvMz1JkrEVzE3ZBL7H94QIHHJo5QfuaVl7k+uP2k32cpbWcqCFE15gQK85pYM/+QTPCmjLfLm//HAGs2i9cTwXoFN53cERa+sHHHIBoFQT9kKCswRJqIPZWyGn5rnZZhnKpIns+83BSZgTCgVS/o=
Date: Thu, 26 May 2005 16:35:16 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050526143516.GA9593@gmail.com>
References: <20050517170824.GA3931@in.ibm.com> <1116354894.4989.42.camel@mulgrave> <20050517192636.GB9121@gmail.com> <1116359432.4989.48.camel@mulgrave> <20050517195650.GC9121@gmail.com> <1116363971.4989.51.camel@mulgrave> <20050521232220.GD28654@gmail.com> <1116770040.5002.13.camel@mulgrave> <20050524153930.GA10911@gmail.com> <1117113563.4967.17.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1117113563.4967.17.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 09:19:23AM -0400, James Bottomley wrote:

> Actually, did you capture anything more after this?

No, I have waited some times, and has nothing more were written to my
palm console, I just thought it wouldn't boot further...

> There's an indication from a previous file you sent:
> 
> Target 1 Negotiation Settings
>         User: 10.000MB/s transfers (10.000MHz, offset 127)
>         Goal: 10.000MB/s transfers (10.000MHz, offset 15)
>         Curr: 10.000MB/s transfers (10.000MHz, offset 15)
> 
> That for some reason the bus is tied to 10MHz (i.e. fast but not ultra).
> The DV began at Ultra, but it should next drop down to FAST.
> 
> Also, when it finally boots up what does
> 
> /sys/class/spi_transport/target1:0:1/min_period
> 
> contain?

Under 2.6.12-rc2 I haven't this file, what the equivalent ?

Thank you very much for taking care of my problem :-)
-- 
	Grégoire Favre
