Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbTA0Is4>; Mon, 27 Jan 2003 03:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbTA0Is4>; Mon, 27 Jan 2003 03:48:56 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:481 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267155AbTA0Is4>;
	Mon, 27 Jan 2003 03:48:56 -0500
Message-ID: <3E34F47D.5040604@us.ibm.com>
Date: Mon, 27 Jan 2003 00:57:33 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Larson <plars@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 4k stacks and BUILD_INTERRUPT
References: <3E34E335.1000600@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't anyone go applying that.  I screwed up the macro definitions.  It
compiled, but the macros aren't complete, so it will die pretty quickly
the first time it hits an interrupt.

I'll fix it and send some real ones tomorrow.
-- 
Dave Hansen
haveblue@us.ibm.com


