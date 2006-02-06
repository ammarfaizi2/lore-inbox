Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWBFJCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWBFJCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWBFJCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:02:23 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:30571 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750802AbWBFJCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:02:22 -0500
Message-ID: <43E7112C.8060001@sw.ru>
Date: Mon, 06 Feb 2006 12:04:44 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Kirill Korotaev <dev@openvz.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org> <p73psm1lg2v.fsf@verdi.suse.de>
In-Reply-To: <p73psm1lg2v.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>+	struct vps_info *owner_vps;
> You don't seem to be any ifdefs for anything. I guess that's ok if the
> final virtualization will be really light weight (let's say not more
> than a few KB of additional memory including runtime overhead). But
> somehow I guess it will be heavier. What are the plans to allow to
> CONFIG it all out for small systems?
Yes, I will add missing ifdefs to make it compilable without 
virtualization at all resulting in the normal kernel.
Thanks for pointing to this.

Kirill

