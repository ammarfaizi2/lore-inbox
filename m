Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTKYJVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 04:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTKYJVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 04:21:54 -0500
Received: from inmail.compaq.com ([161.114.1.206]:64017 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262131AbTKYJVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 04:21:53 -0500
Message-ID: <3FC320EE.7010700@mailandnews.com>
Date: Tue, 25 Nov 2003 14:59:18 +0530
From: Raj <raju@mailandnews.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gong Su <gongsu@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Replacing tcp_v4_rcv from a module
References: <200311250821.hAP8L6OW006754@sutton.cs.columbia.edu>
In-Reply-To: <200311250821.hAP8L6OW006754@sutton.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gong Su wrote:

>I need some customized function inside tcp_v4_rcv so I wrote a module to
>replace tcp_protocol->handler with my own function pointer; and currently
>  
>
Try calling synchronize_net() after your modification and see if it helps.

/Raj

