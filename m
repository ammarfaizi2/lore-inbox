Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSHBSxO>; Fri, 2 Aug 2002 14:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSHBSxO>; Fri, 2 Aug 2002 14:53:14 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18907 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S316662AbSHBSxN>;
	Fri, 2 Aug 2002 14:53:13 -0400
Message-ID: <3D4AD5CF.7020005@us.ibm.com>
Date: Fri, 02 Aug 2002 11:56:15 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: Kasper Dupont <kasperd@daimi.au.dk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Race condition?
References: <3D4A8D45.49226E2B@daimi.au.dk> <3D4ABA9D.8060307@us.ibm.com> <200208021748.g72Hm8m02852@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The failure is because 0 means no limit.
limit==0
processes==0
processes++
processes > limit

I'll have a patch generated in a couple of minutes.

-- 
Dave Hansen
haveblue@us.ibm.com

