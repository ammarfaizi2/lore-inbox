Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVEaLbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVEaLbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 07:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVEaLbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 07:31:07 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:31689 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261869AbVEaLbE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 07:31:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rQ2hqR7owBBIbA/RtLYkkjAl/mnw9Ydutjf6GtomovZSjHvYFQyqq4RxIstT8hW33Pxf3WpOpQNf/Z5GYmYP30WYHDqLGJShKQ7VS97Tjk1jYD4iZzrCD7VJtwRK9pcqtaHMS0oOo1zHHNiWfFbDoCfBt6teXY/VQuoQGVOR0YY=
Message-ID: <4c14a25d050531043158fbed1b@mail.gmail.com>
Date: Tue, 31 May 2005 17:01:03 +0530
From: Hari N <hari2n@gmail.com>
Reply-To: Hari N <hari2n@gmail.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: RT patch acceptance
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050531111445.GA35122@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4299A98D.1080805@andrew.cmu.edu> <429B1898.8040805@andrew.cmu.edu>
	 <429B2160.7010005@yahoo.com.au>
	 <20050530222747.GB9972@nietzsche.lynx.com>
	 <429BBC2D.70406@yahoo.com.au>
	 <20050531020957.GA10814@nietzsche.lynx.com>
	 <429C2A64.1040204@andrew.cmu.edu> <429C2F72.7060300@yahoo.com.au>
	 <429C4112.2010808@andrew.cmu.edu> <20050531111445.GA35122@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 May 2005 13:14:45 +0200, Andi Kleen <ak@muc.de> wrote:
> 
> Are you sure it is not only disk IO? In theory updatedb shouldn't
> need much CPU, but it eats a lot of memory and causes stalls
> in the disk (or at least that was my interpration on the stalls I saw)
> If there is really a scheduling latency problem with updatedb
> then that definitely needs to be fixed in the stock kernel.
 
Yeah true...I have actually never observed updatedb taking much of my
CPU cycles. It just eats up a lot of memory. When the load average on
the system is high, sometimes updatedb even results in a system
freeze.

-- 
Hari
