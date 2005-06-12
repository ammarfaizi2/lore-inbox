Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVFLTTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVFLTTN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVFLTTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:19:13 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:19972 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262636AbVFLQaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 12:30:05 -0400
Message-ID: <42AC6310.7030809@rtr.ca>
Date: Sun, 12 Jun 2005 12:30:08 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: kallol@nucleodyne.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Fwd: Re: Performance figure for sx8 driver
References: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>
In-Reply-To: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kallol@nucleodyne.com wrote:
> 
> 
> Hello Jeff,
>            How did you verify that performance improved making the
> changes those
> you suggested?
> 
> hdparm does not show it.

My hdparm tool performs a single I/O at a time,
disregarding any kernel read-ahead that may be added on.

As such, it won't often show the effects of queued commands
as well as some other test might.

Cheers
