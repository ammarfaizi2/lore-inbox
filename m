Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVGVJFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVGVJFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVGVJFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:05:53 -0400
Received: from mail.dvmed.net ([216.237.124.58]:42407 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261180AbVGVJFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:05:51 -0400
Message-ID: <42E0B6E4.1030303@pobox.com>
Date: Fri, 22 Jul 2005 05:05:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 10 GB in Opteron machine
References: <20050722105516.6ccffb8f.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20050722105516.6ccffb8f.Christoph.Pleger@uni-dortmund.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Pleger wrote:
> At last I found out that setting HIGHMEM support to 64 GB is the
> problem. But is it really not possible to use more than 4GB on an
> Opteron machine?

Build and boot a 64-bit kernel, not a 32-bit kernel.

There is no highmem option for the 64-bit kernel, because it doesn't 
need one.

	Jeff


