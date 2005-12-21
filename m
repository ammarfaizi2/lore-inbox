Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVLUJdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVLUJdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVLUJdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:33:44 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:2200 "EHLO mail.towertech.it")
	by vger.kernel.org with ESMTP id S932334AbVLUJdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:33:43 -0500
Date: Wed, 21 Dec 2005 10:30:22 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051221103022.3ab6e818@inspiron>
In-Reply-To: <20051221015012.GC86547@gaz.sfgoth.com>
References: <20051220214511.12bbb69c@inspiron>
	<20051220211344.GA14403@infradead.org>
	<20051220222343.71ee6bab@inspiron>
	<20051221015012.GC86547@gaz.sfgoth.com>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005 17:50:12 -0800
Mitchell Blank Jr <mitch@sfgoth.com> wrote:

> > > exporting static symbols is pretty wrong.  Exporting tables is pretty
> > > bad style aswell.
> > 
> >  Tables like this one are often used in rtc drivers. What
> >  can I use instead?
> 
> Why not just provide a macro in a .h file?  Something like:
> 
> /* Days in month -- month is in the range (0..11), no leap year */
> #define rtc_days_in_month(mon)	(28 + ((0xEEFBB3 >> ((mon) * 2)) & 3))

 I just noticed i was exporting a similar functions, so
the table export can be removed.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

