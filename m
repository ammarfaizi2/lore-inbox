Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbSLKGXb>; Wed, 11 Dec 2002 01:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267028AbSLKGX2>; Wed, 11 Dec 2002 01:23:28 -0500
Received: from holomorphy.com ([66.224.33.161]:4768 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267027AbSLKGX0>;
	Wed, 11 Dec 2002 01:23:26 -0500
Date: Tue, 10 Dec 2002 22:30:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] epoll: don't printk pointer value
Message-ID: <20021211063031.GH9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, davidel@xmailserver.org,
	linux-kernel@vger.kernel.org
References: <1039588045.833.3.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039588045.833.3.camel@phantasy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 01:27:25AM -0500, Robert Love wrote:
> I really cannot think of a good reason why eventpoll_init() should print
> a pointer value to user-space - especially the value of current?
> I do not think this is good practice and someone might even consider it
> a security hole.  Personally, I would prefer to remove the "successfully
> initialized" message altogether, but at the very least can we not print
> current's address?

You're still passing current as an argument to the printk.


Bill
