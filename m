Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVE1Jxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVE1Jxa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 05:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVE1Jxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 05:53:30 -0400
Received: from coderock.org ([193.77.147.115]:49283 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262672AbVE1Jx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 05:53:26 -0400
Date: Sat, 28 May 2005 11:53:18 +0200
From: Domen Puncer <domen@coderock.org>
To: Frank Pavlic <pavlic@de.ibm.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/10] s390: schedule_timeout cleanup in ctctty
Message-ID: <20050528095318.GA22962@nd47.coderock.org>
References: <20050527090242.GD8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527090242.GD8213@de.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/05 11:02 +0200, Frank Pavlic wrote:
> 
> [patch 4/10] s390: schedule_timeout cleanup in ctctty.
> 
> From: Domen Puncer <domen@coderock.org>
> 
> Use msleep_interruptible() instead of schedule_timeout()
> to guarantee the task delays as expected.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Actually it's from:
Nishanth Aravamudan <nacc@us.ibm.com>

Since then, I updated scripts to add the "From: " in the
body, so this shouldn't be an issue in the future.

> Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 


	Domen
