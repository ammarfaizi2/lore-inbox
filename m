Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTKYReq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTKYReq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:34:46 -0500
Received: from [66.62.77.7] ([66.62.77.7]:45037 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S262369AbTKYRen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:34:43 -0500
Subject: Re: palm pilot broken in test 10
From: Dax Kelson <dax@gurulabs.com>
To: "Mr. Mailing List" <mailinglistaddie@yahoo.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20031125101529.77057.qmail@web60202.mail.yahoo.com>
References: <20031125101529.77057.qmail@web60202.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1069781651.3452.8.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 25 Nov 2003 10:34:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-25 at 03:15, Mr. Mailing List wrote:
> visor ttyUSB2: Handspring Visor / Palm OS converter
> now disconnected from ttyUSB2
> visor ttyUSB3: Handspring Visor / Palm OS converter
> now disconnected from ttyUSB3
> usbserial 4-2:1.0: device disconnected
> 
> 
> worked several versions ago, then was broken, then
> fixed,  and has been broken the last several versions.

I can confirm that there is a problem in test10. I have a Treo600 and
plugging it in (and/or pressing the hotsync button) results in no
autoloading of the visor module. If I manually modprobe the visor
module, then when I connect/disconnect and/or press hotsync there is no
activity viewable via "dmesg".

Greg, how can I troubleshoot this better for you?

Dax Kelson
Guru Labs

