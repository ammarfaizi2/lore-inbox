Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWI1RRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWI1RRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWI1RRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:17:11 -0400
Received: from mx0.towertech.it ([213.215.222.73]:22973 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1751960AbWI1RRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:17:10 -0400
Date: Thu, 28 Sep 2006 19:17:04 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc driver rtc-pcf8563 century bit inversed
Message-ID: <20060928191704.4cd754ce@inspiron>
In-Reply-To: <1159453190.8837.6.camel@jb-portable>
References: <1159453190.8837.6.camel@jb-portable>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 16:19:49 +0200
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com> wrote:

> The century bit PCF8563_MO_C in the month register is misinterpreted. It
> is set to 1 for the 20th century and 0 for 21th, and the driver is
> expecting the opposite behavior.
> 
> Here is a small patch to address this issue.
> Thanks for all the good work!

 Thanks for spotting this, please fwd to
 akpm for inclusion in -mm .

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

