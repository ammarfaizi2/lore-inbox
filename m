Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTE3KXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 06:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTE3KXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 06:23:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47576
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263234AbTE3KXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 06:23:50 -0400
Subject: Re: IRQ_NONE definition in NCR5380 driver...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0305300024550.14345@skynet>
References: <Pine.LNX.4.53.0305300024550.14345@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054287550.23566.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 10:39:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-30 at 00:27, Dave Airlie wrote:
> Currently the NCR5380.h defines IRQ_NONE to be 255, is there any special
> reason for this? why not use UINT32_MAX-1?..

Shouldnt cause any problems at all. I have the same problem with the IDE
layer and "picking an IRQ that cant exist". Maybe we need a global
IRQ_NONE type value

