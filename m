Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319091AbSIJJtm>; Tue, 10 Sep 2002 05:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319094AbSIJJtm>; Tue, 10 Sep 2002 05:49:42 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:39776 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S319091AbSIJJtl>;
	Tue, 10 Sep 2002 05:49:41 -0400
Date: Tue, 10 Sep 2002 11:54:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid_max hang again...
Message-ID: <20020910095423.GA12068@win.tue.nl>
References: <Pine.LNX.4.33.0209091836470.14828-100000@ccvsbarc.wipro.com> <307667352.1031558825@[10.10.2.3]> <20020909223956.GA2093@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909223956.GA2093@pegasys.ws>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 03:39:56PM -0700, jw schultz wrote:

> The current repeated scanning is awful.

I don't know what the problem is. The present scheme is very
efficient on the average (since the pid space is very large,
much larger than the number of processes, this scan is hardly
ever done). All proposed alternatives are clumsy, incorrect,
and much less efficient.

Andries
