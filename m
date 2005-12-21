Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVLUXKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVLUXKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVLUXKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:10:12 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:48310 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S932322AbVLUXKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:10:11 -0500
Date: Thu, 22 Dec 2005 00:10:46 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051222001046.02958ca1@inspiron>
In-Reply-To: <d120d5000512211143ge189479qf1916741479586b4@mail.gmail.com>
References: <20051220214511.12bbb69c@inspiron>
	<200512202101.39498.dtor_core@ameritech.net>
	<20051221105001.226178f1@inspiron>
	<d120d5000512211143ge189479qf1916741479586b4@mail.gmail.com>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005 14:43:01 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Well, I don't know what will it buy you: if ops is NULL
> try_module_get(ops->owner) will OOPS just as happily as original code.
> 
> Your class_device has to hold on to all data structures that are
> referenced from sysfs attributes untils its ->release() function is
> called. Alternatively you could stuck a mutex and a flag somewhere in
> driver data and take it when unregistering class device and also in
> all attributes (and chech the flag there).

 Thanks for your help.. I will try to implement a solution
 ans post it as soon as possible. 


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

