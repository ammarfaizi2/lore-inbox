Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271430AbTGQLNb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271431AbTGQLNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:13:31 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:16121 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S271430AbTGQLN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:13:28 -0400
Message-ID: <3F168855.50708@wmich.edu>
Date: Thu, 17 Jul 2003 07:28:21 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030628
X-Accept-Language: en
MIME-Version: 1.0
To: "Andrew S. Johnson" <andy@asjohnson.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: i2c-proc module
References: <200307170540.26684.andy@asjohnson.com>
In-Reply-To: <200307170540.26684.andy@asjohnson.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew S. Johnson wrote:
> I2C wants an i2c-proc module, but I can't find where
> to config it.  Something like this happens when I run sensors:
> 
> /proc/sys/dev/sensors/chips or /proc/bus/i2c unreadable;
> Make sure you have done 'modprobe i2c-proc'!
> 
> There was an i2c-proc module with lm_sensors 2.7.0.  What
> am I missing?
> 
> Andy Johnson


lm_sensors uses sysfs now. Not proc. Sensors hasn't been updated. You'll 
have to use cat.

