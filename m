Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVJYHqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVJYHqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVJYHqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:46:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:26081 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932068AbVJYHqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:46:06 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] x86_64: 2.6.14 machine_emergency_restart
Date: Tue, 25 Oct 2005 09:46:52 +0200
User-Agent: KMail/1.8
Cc: Yinghai Lu <yinghai.lu@amd.com>, linux-kernel@vger.kernel.org
References: <86802c440510241811w6e3c6d77o3a5e1ca8ad20900a@mail.gmail.com>
In-Reply-To: <86802c440510241811w6e3c6d77o3a5e1ca8ad20900a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510250946.53269.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 October 2005 03:11, Yinghai Lu wrote:
> Andi,
>
> in arch/x86_64/kernel/reboot.c , machine_emergency_restart,
>
> why it need to loop 100 times...? it could hold the restart for 10 seconds


No particular reason - just inherited that from i386. You're right it's a bit 
too long. I will change it to 10 times.

-Andi
