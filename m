Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289022AbSAIVHG>; Wed, 9 Jan 2002 16:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289031AbSAIVG6>; Wed, 9 Jan 2002 16:06:58 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:36349 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S289024AbSAIVGH>; Wed, 9 Jan 2002 16:06:07 -0500
Date: Wed, 9 Jan 2002 13:10:13 -0800
From: Chris Wright <chris@wirex.com>
To: Christopher James <cjames@berkeley.innomedia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast fails when interface changed
Message-ID: <20020109131013.C24733@figure1.int.wirex.com>
Mail-Followup-To: Christopher James <cjames@berkeley.innomedia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C3C8D4D.621A4696@berkeley.innomedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3C8D4D.621A4696@berkeley.innomedia.com>; from cjames@berkeley.innomedia.com on Wed, Jan 09, 2002 at 10:34:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christopher James (cjames@berkeley.innomedia.com) wrote:
> We are running an application that uses multicasting
> on Linux kernel 2.2.19. The application is
> connected to two network interfaces for redundancy
> purposes - only one interface is active at a time.
> When the application starts up on the first interface,
> the application can send and receive multicast messages.
> We then use ifconfig to bring down the first interface,
> and use ifconfig to bring up the second interface. The application
> works with the exception that it cannot receive multicast
> packets (it can still send multicast packets).

does your app use INADDR_ANY for imr_interface when you join the
multicast group?

-chris
