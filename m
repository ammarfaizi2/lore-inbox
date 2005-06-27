Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVF0TLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVF0TLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVF0TK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:10:28 -0400
Received: from kirby.webscope.com ([204.141.84.57]:63926 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S261732AbVF0TJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:09:50 -0400
Message-ID: <42C04ED2.6060802@m1k.net>
Date: Mon, 27 Jun 2005 15:09:06 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: fix silly config option.
References: <20050627053928.GA9759@redhat.com> <42C04D82.9000108@m1k.net> <20050627190728.GA11186@redhat.com>
In-Reply-To: <20050627190728.GA11186@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Mon, Jun 27, 2005 at 03:03:30PM -0400, Michael Krufky wrote:
>
> > +config CONFIG_TUNER_MULTI_I2C
> > +#define CONFIG_TUNER_MULTI_I2C /**/
> > +#ifdef CONFIG_TUNER_MULTI_I2C
> > +#ifdef CONFIG_TUNER_MULTI_I2C
> > +#ifdef CONFIG_TUNER_MULTI_I2C
> > +#ifndef CONFIG_TUNER_MULTI_I2C
> > +#ifdef CONFIG_TUNER_MULTI_I2C
> > 
> > ... So in fact, after applying your patch above,  NOW it is a silly 
> > config option, which in effect, removed all functionality of 
> > CONFIG_TUNER_MULTI_I2C alltogether
>
>Err, no. Note how no other config options have CONFIG_ prepended
>to them. Kconfig magic does this for you implicitly.
>
OOPS!  I stand corrected.  :-)

-- 
Michael Krufky


