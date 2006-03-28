Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWC1X5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWC1X5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWC1X5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:57:53 -0500
Received: from mx0.towertech.it ([213.215.222.73]:38283 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S964849AbWC1X5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:57:53 -0500
Date: Wed, 29 Mar 2006 01:57:38 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][UPDATE] rtc: Added support for ds1672 control
Message-ID: <20060329015738.5dbbb22d@inspiron>
In-Reply-To: <E135E70C-2F39-4007-B4CC-4D1AEBE2EE74@kernel.crashing.org>
References: <20060329004122.64e91176@inspiron>
	<Pine.LNX.4.44.0603281654370.22846-100000@gate.crashing.org>
	<20060329014851.0f54da89@inspiron>
	<E135E70C-2F39-4007-B4CC-4D1AEBE2EE74@kernel.crashing.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 17:52:00 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> >
> >  shouldn't this be
> >  if (err < 0)
> > 	return err;
> 
> It could be, but doesn't need to.  ds1672_get_control either returns  
> 0 (success) or non-zero (-EIO) for failure.
> 
> >> +	/* read control register */
> >> +	err = ds1672_get_control(client, &control);
> >> +	if (err) {
> >> +		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
> >> +		goto exit_detach;
> >> +	}
> >
> >  ditto.
> 
> ditto.

 ok. will apply, thanks.


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

