Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWJOV1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWJOV1W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 17:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWJOV1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 17:27:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:40913 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030250AbWJOV1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 17:27:21 -0400
Subject: Re: [PATCH 1/5] remove TxStartThresh and RxEarlyThresh
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com
In-Reply-To: <1160855725.2266.1.camel@localhost.localdomain>
References: <1160855725.2266.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 07:26:37 +1000
Message-Id: <1160947597.22522.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-14 at 15:55 -0400, Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> Change Logs:
> For patent issue need to remove TxStartThresh and RxEarlyThresh. This patent 
> is cut-through patent. If use this function, Tx will start to transmit after 
> few data be move in to Tx FIFO. We are not allow to use those function in 
> DFE530/DFE550/DFE580/DL10050/IP100/IP100A. It will decrease a little 
> performance.

Somebody patented FIFO thresholds ? Gack ?

Ben.


