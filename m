Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWFTV4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWFTV4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWFTV4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:56:11 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:38870 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751118AbWFTV4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:56:09 -0400
Date: Tue, 20 Jun 2006 23:56:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Aneesh Kumar <aneesh.kumar@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sparse and devinet_ioctl
In-Reply-To: <cc723f590606200424i53cd30edre8f9292dbcde843b@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0606202355470.17281@yvahk01.tjqt.qr>
References: <cc723f590606200424i53cd30edre8f9292dbcde843b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> How do i make sure i can call devinet_ioctl from kernel without having
> a sparse warning.
>
> The call i want to use was SIOCGIFADDR
>
> Right now i am patching it as below
>
> _devinet_ioctl(SIOCGIFADDR, &ifr)

I am sure you can do it over netlink (the preffered way for developers as 
it seems).


Jan Engelhardt
-- 
