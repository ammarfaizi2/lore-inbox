Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWERVMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWERVMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWERVMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:12:15 -0400
Received: from sccrmhc11.comcast.net ([204.127.200.81]:18886 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751247AbWERVMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:12:14 -0400
Date: Thu, 18 May 2006 14:14:13 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: [PATCH] Add driver for ARM AMBA PL031 RTC
Message-ID: <20060518211413.GA30137@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20060516214813.GA28414@plexity.net> <20060517010259.5a035b20@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517010259.5a035b20@inspiron>
Organization: Plexity Networks
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 17 2006, at 01:02, Alessandro Zummo was caught saying:
> > +	case RTC_AIE_ON:
> > +		__raw_writel(0, ldata->base + RTC_MIS);
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> 
>  pleasew return -ENOIOCTLCMD instead of -EINVAL . I know, I will have
> to fix the other drivers to do the same.

So I just tried building my kernel and this symbol is not defined...
Do you have a separate patch that defines it or is it just in -mm?

~Deepak


-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

I am not a consumer. My existence on this planet is not defined by my
relationship to a producer of goods.  I was not put on this planet to
consume goods from a company for their profit. - Michael W.
