Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWIYAMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWIYAMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 20:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWIYAMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 20:12:15 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43184 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751482AbWIYAMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 20:12:15 -0400
Message-ID: <45171EDA.1040602@garzik.org>
Date: Sun, 24 Sep 2006 20:12:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Grant Coady <gcoady.lk@gmail.com>
CC: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1 make oldconfig missed SATA
References: <n73eh2d2ido2oimfqn798hp029lshga5qf@4ax.com>
In-Reply-To: <n73eh2d2ido2oimfqn798hp029lshga5qf@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> 2.6.18-mm1 make oldconfig didn't pull SATA config from 2.6.18 old screen to 
> the new libata screen, caught me out -- this may be an issue for 2.6.19 
> upgraders that a quick make oldconfig rebuild will fail to boot?

The symbols changed.  No facility for upgrading .config symbols... 
people who config their own kernels are expected to handle such things...

	Jeff


