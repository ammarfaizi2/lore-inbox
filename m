Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266638AbUAWSjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUAWSjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:39:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:38878 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266638AbUAWSjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:39:04 -0500
Date: Fri, 23 Jan 2004 10:39:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Ischebeck <mail@jan-ischebeck.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm2
Message-Id: <20040123103959.4dcf5b58.akpm@osdl.org>
In-Reply-To: <1074870538.5122.9.camel@JHome.uni-bonn.de>
References: <1074870538.5122.9.camel@JHome.uni-bonn.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Ischebeck <mail@jan-ischebeck.de> wrote:
>
> Hi Andrew,
> 
> With the latest pmtmr fixes, synaptics mouse driver is in sync again and
> my bogomips are correct too. (synaptics had been loosing packages in -mm
> releases the last weeks)

OK, thanks.

> Only the radeon dri driver cannot be inserted because of an missing
> symbol: 
> radeon: Unknown symbol cmpxchg

You'll need to disable 386 support in the processor selection menu.
