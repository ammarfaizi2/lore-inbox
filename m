Return-Path: <linux-kernel-owner+w=401wt.eu-S1422735AbWLUFoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbWLUFoP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 00:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWLUFoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 00:44:15 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:32613 "EHLO
	asav07.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422735AbWLUFoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 00:44:15 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApkZAHatiUVKhRO4Vmdsb2JhbACHL4ZBARMPCSE
From: Dmitry Torokhov <dtor@insightbb.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] pc110pad: return proper error
Date: Thu, 21 Dec 2006 00:44:10 -0500
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20061219084453.GH4049@APFDCB5C>
In-Reply-To: <20061219084453.GH4049@APFDCB5C>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612210044.11485.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 03:44, Akinobu Mita wrote:
> According to the comment, "if we find any PCI devices in the machine,
> we don't have a PC110" in pc110pad.c, we should return -ENODEV
> rather than -ENOENT in this case.
> 

Applied, thank you.

-- 
Dmitry
