Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUEaECb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUEaECb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 00:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUEaECb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 00:02:31 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:12015 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264530AbUEaECZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 00:02:25 -0400
Message-ID: <40BAAE46.3040701@nortelnetworks.com>
Date: Mon, 31 May 2004 00:02:14 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ndiamond@despammed.com
CC: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
References: <200405310250.i4V2ork05673@mailout.despammed.com>
In-Reply-To: <200405310250.i4V2ork05673@mailout.despammed.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ndiamond@despammed.com wrote:
> Mans Rullgard replied to me:

>  >What you should do is think again about why you need all this floating
>  >point in the kernel.
> 
> To control a device.

Note that there is nothing stopping you from doing fixed-point math in 
the kernel.  Depending on the application, this may be sufficient.

Chris
