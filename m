Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266369AbUAOBOA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266382AbUAOBN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:13:56 -0500
Received: from nobody.lpr.e-technik.tu-muenchen.de ([129.187.151.1]:3288 "EHLO
	nobody.lpr.e-technik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S266369AbUAOBMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:12:35 -0500
Message-ID: <4005E8FF.4050700@metrowerks.com>
Date: Thu, 15 Jan 2004 02:12:31 +0100
From: Bernhard Kuhn <bkuhn@metrowerks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: inaky.perez-gonzalez@intel.com
CC: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2.1
References: <0401141449.CaWdGcXb9b6caaodvdxcqcwdkc7cOazb9031@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inaky.perez-gonzalez@intel.com wrote:

> This code proposes an implementation of kernel based mutexes,

Pretty interessting stuff! I will inspect if i could combine
it with the "real-time interrupts" i recently described
(http://www.linuxdevices.com/articles/AT6105045931.html).

Currently i'm protecting critical areas with "prioritized
spinlocks" that don't provide a priority inversion aviodance
scheme. Having "real" mutexes with priority inheritence
should be pretty helpfull to make the kernel hard real time
aware.

best regards

Bernhard

