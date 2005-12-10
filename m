Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVLJHF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVLJHF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVLJHF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:05:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964927AbVLJHFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:05:55 -0500
Date: Fri, 9 Dec 2005 23:05:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: mchehab@brturbo.com.br
Cc: linux-kernel@vger.kernel.org, mchehab@infradead.org, js@linuxtv.org,
       linux-dvb-maintainer@linuxtv.org, hverkuil@xs4all.nl,
       mchehab@brturbo.com.br
Subject: Re: [PATCH 31/56] V4L/DVB (3064) Some cleanups on msp3400
Message-Id: <20051209230509.2b39d431.akpm@osdl.org>
In-Reply-To: <1134084177.7047.168.camel@localhost>
References: <1134084177.7047.168.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@brturbo.com.br wrote:
>
> From: Hans Verkuil <hverkuil@xs4all.nl>
> 
> - Change function order to reduce usage of function
>   prototypes.

I tweaked this one to reflect changes in struct i2c_driver which are in
Greg's tree.  Please check the result.

This probably means that these patches will be merged after Greg merges up.

