Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbVIIVd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbVIIVd2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbVIIVd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:33:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:61163 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030375AbVIIVd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:33:27 -0400
Date: Fri, 9 Sep 2005 14:32:50 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 2.6] hwmon: via686a: save 0.5k by long v[256] -> s16 v[256]
Message-ID: <20050909213250.GA29011@kroah.com>
References: <200509010910.14824.vda@ilport.com.ua> <20050901155915.GB1235@kroah.com> <200509020854.37192.vda@ilport.com.ua> <20050903102227.03312247.khali@linux-fr.org> <20050903161331.1c76153d.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903161331.1c76153d.khali@linux-fr.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 04:13:31PM +0200, Jean Delvare wrote:
> Hi Greg, all,
> 
> > This patch doesn't apply on top of my stack, first because the
> > hardware monitoring drivers have been moved to drivers/hwmon, second
> > because the via686a driver had indentation cleanups since 2.6.12.
> > 
> > Could you please provide this patch against 2.6.13-mm1?
> 
> On Denis' request, I have done that myself.

Unfortunatly, no one noticed that this patch adds a build warning :(

So I'm not going to apply it, sorry.

thanks,

greg k-h
