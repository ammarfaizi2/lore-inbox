Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263250AbTCNEGe>; Thu, 13 Mar 2003 23:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263251AbTCNEGe>; Thu, 13 Mar 2003 23:06:34 -0500
Received: from dyn-ctb-210-9-246-80.webone.com.au ([210.9.246.80]:41220 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S263250AbTCNEGd>;
	Thu, 13 Mar 2003 23:06:33 -0500
Message-ID: <3E7157C4.2040901@cyberone.com.au>
Date: Fri, 14 Mar 2003 15:17:08 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Shane Shrybman <shrybman@sympatico.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-mm>1 Problems starting gnome?
References: <1047613046.2267.97.camel@mars.goatskin.org>
In-Reply-To: <1047613046.2267.97.camel@mars.goatskin.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Shrybman wrote:

>Hi Andrew et al.
>
>I am having problems starting gnome in the 2.5.64-mmX (X>1). 2.5.64 and
>2.5.64-mm1 work ok, 2.5.64-mm2 doesn't compile for me and the more
>recent -mm don't work.
>
Processes getting stuck in D is most likely to be an anticipatory
scheduler bug. Please boot with elevator=deadline. Thanks.

