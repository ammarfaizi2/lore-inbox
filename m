Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262102AbSJNTHp>; Mon, 14 Oct 2002 15:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262105AbSJNTHp>; Mon, 14 Oct 2002 15:07:45 -0400
Received: from zeus.kernel.org ([204.152.189.113]:10880 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262102AbSJNTHo>;
	Mon, 14 Oct 2002 15:07:44 -0400
Message-ID: <3DAB1738.2030706@pobox.com>
Date: Mon, 14 Oct 2002 15:12:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rename _bh to _softirq
References: <5.1.0.14.2.20021014115238.084140f8@mail1.qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maksim (Max) Krasnyanskiy wrote:
> Hi Folks,
> 
> Old BHs have been almost completely replaced with tasklets and softirqs.


In 2.5?  They have been replaced by work queues...  though in some cases 
manual conversion to tasklets is more appropriate.

	Jeff



