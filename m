Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTKLDwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 22:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTKLDwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 22:52:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32198 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261552AbTKLDwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 22:52:39 -0500
Message-ID: <3FB1AE78.2050304@pobox.com>
Date: Tue, 11 Nov 2003 22:52:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kirk bae <justformoonie@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: So, Poll is not scalable... what to do?
References: <LAW12-F60bw5TYIo9WF0002bec8@hotmail.com>
In-Reply-To: <LAW12-F60bw5TYIo9WF0002bec8@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kirk bae wrote:
> If poll is not scalable, which method should I use when writing 
> multithreaded socket server?
> 
> What is the most efficient model to use?


epoll, thread pools, AIO...

