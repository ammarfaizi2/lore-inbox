Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUJOMm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUJOMm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 08:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUJOMlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 08:41:24 -0400
Received: from [80.227.59.61] ([80.227.59.61]:39583 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S267779AbUJOMjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 08:39:15 -0400
Message-ID: <416FC4E2.6000206@0Bits.COM>
Date: Fri, 15 Oct 2004 16:38:58 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20041011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 038 release
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also going from 036 to 038 broke centrino wireless ipw2200
firmware autoloading. Removing

	/etc/hotplug.d/default/05-wait_for_sysfs.hotplug

fixed the problem.

M
