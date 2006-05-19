Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWESHBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWESHBI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 03:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWESHBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 03:01:08 -0400
Received: from mx0.towertech.it ([213.215.222.73]:26776 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1750948AbWESHBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 03:01:07 -0400
Date: Fri, 19 May 2006 09:00:59 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: dsaxena@plexity.net
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: [PATCH] Add driver for ARM AMBA PL031 RTC
Message-ID: <20060519090059.6a4ae921@inspiron>
In-Reply-To: <20060518211413.GA30137@plexity.net>
References: <20060516214813.GA28414@plexity.net>
	<20060517010259.5a035b20@inspiron>
	<20060518211413.GA30137@plexity.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2006 14:14:13 -0700
Deepak Saxena <dsaxena@plexity.net> wrote:

> On May 17 2006, at 01:02, Alessandro Zummo was caught saying:
> > > +	case RTC_AIE_ON:
> > > +		__raw_writel(0, ldata->base + RTC_MIS);
> > > +		return 0;
> > > +	}
> > > +
> > > +	return -EINVAL;
> > > +}
> > 
> >  pleasew return -ENOIOCTLCMD instead of -EINVAL . I know, I will have
> > to fix the other drivers to do the same.
> 
> So I just tried building my kernel and this symbol is not defined...
> Do you have a separate patch that defines it or is it just in -mm?

 it's in linux/errno.h 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

