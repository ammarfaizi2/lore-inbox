Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbSJOUV2>; Tue, 15 Oct 2002 16:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264648AbSJOUV2>; Tue, 15 Oct 2002 16:21:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13992 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261745AbSJOUVZ>;
	Tue, 15 Oct 2002 16:21:25 -0400
Date: Tue, 15 Oct 2002 13:19:29 -0700 (PDT)
Message-Id: <20021015.131929.103080718.davem@redhat.com>
To: maxk@qualcomm.com
Cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rename _bh to _softirq
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20021015131839.01c1a008@mail1.qualcomm.com>
References: <5.1.0.14.2.20021015121958.01b4acd8@mail1.qualcomm.com>
	<20021015.124204.108190832.davem@redhat.com>
	<5.1.0.14.2.20021015131839.01c1a008@mail1.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
   Date: Tue, 15 Oct 2002 13:23:28 -0700

   _bh is not a "base handler" it stands for "bottom half".
   
All of these phrases mean the same thing to me.

Do you want to know what is different?  "tasklets",
they are a totally different abstraction, as are
"work queues".

"base handler" and "bottom half" all refer to an execution
context, and these days that means softirq.

   
   
   
   
