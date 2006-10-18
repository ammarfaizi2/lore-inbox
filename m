Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWJROzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWJROzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWJROzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:55:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:7062 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161098AbWJROzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:55:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=U2sJ4+TB47VxOmQpZnNQjsaBgcKF5xmzcYXzXZ7mAC7nSpfm/Z4ld3hxOvDbw1CpSyAMIgaQSeZ3+Sr39BV1LEjl/5dnnYWTpNJWPXAqshZc11Lu9rXZHZRkAvYBSV+uRIruvqPrJSuAbQzw6vQKY34d9CZqmRdpT0ghuSjbeik=
Message-ID: <45364049.3030404@innova-card.com>
Date: Wed, 18 Oct 2006 16:55:05 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>
In-Reply-To: <20061013023218.31362830.maxextreme@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Miguel Ojeda Sandonis wrote:
> Andrew, here it is the complete patch again as you requested.
> 

sorry for coming lately, I just noticed your patch in -mm tree.

Did you took a look at drivers/video/arcfb.c driver ?
It seems to be a fb driver for ks108 lcd controller. A lot of code
is related to the platform though and the controller is driven
through GPIO but have you tried to split the code for sharing
controller specific code. Note, I don't say it's a good idea, it's
just a question that comes in mind.

Also you create driver/auxdisplay directory whereas drivers such
the one I mentioned previously is located in drivers/video. Why
not putting your driver in driver/video ?

		Franck
