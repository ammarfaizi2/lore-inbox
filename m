Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317806AbSGXX2J>; Wed, 24 Jul 2002 19:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317922AbSGXX2J>; Wed, 24 Jul 2002 19:28:09 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:38823 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317806AbSGXX2J>; Wed, 24 Jul 2002 19:28:09 -0400
Date: Thu, 25 Jul 2002 00:30:57 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
Message-ID: <20020725003057.A8430@kushida.apsleyroad.org>
References: <20020724144433.B7192@kushida.apsleyroad.org> <Pine.LNX.4.33.0207241142320.2117-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0207241142320.2117-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jul 24, 2002 at 11:48:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Like your example, the only uses I've had personally (DVD playback) have
> really had an empty select, so it wasn't really select itself that was 
> horribly important.

All the real examples I've encountered are waiting on file descriptors
too -- and occasionally also signals.

-- Jamie
