Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUBWW7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbUBWW4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:56:40 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:3090 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262077AbUBWWzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:55:00 -0500
Date: Mon, 23 Feb 2004 22:54:57 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: Christoph Hellwig <hch@infradead.org>, Michael Hunold <hunold@linuxtv.org>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] tda1004x DVB frontend update
Message-ID: <20040223225457.A15536@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	Michael Hunold <hunold@linuxtv.org>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <10775702831806@convergence.de> <10775702843054@convergence.de> <20040223211844.A14186@infradead.org> <403A831B.7040307@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <403A831B.7040307@convergence.de>; from hunold@convergence.de on Mon, Feb 23, 2004 at 11:47:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 11:47:55PM +0100, Michael Hunold wrote:
> > Why would the kernel driver want to know the exact path of the firmware file?
> 
> Because we don't use the in-kernel firmware loader at the moment.
> 
> The driver comes from a time were 2.4 didn't have the firmware loader 
> and drivers cloned the firmware loading stuff from one of the soundcard 
> drivers.

Sorry, but that's a bad excuse.  It's bogus in 2.4 too (or any given
kernel).

