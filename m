Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSHUA4i>; Tue, 20 Aug 2002 20:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSHUA4h>; Tue, 20 Aug 2002 20:56:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:780 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317623AbSHUA4g>;
	Tue, 20 Aug 2002 20:56:36 -0400
Message-ID: <3D62E638.9010408@mandrakesoft.com>
Date: Tue, 20 Aug 2002 21:00:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Troy Wilson <tcw@tempest.prismnet.com>
CC: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com, tcw@prismnet.com
Subject: Re: mdelay causes BUG, please use udelay
References: <200208202350.g7KNoBJG036692@tempest.prismnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Troy Wilson wrote:
> -    msec_delay(10);
> +    usec_delay(10000);


not the right fix :)

