Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267340AbUHPCQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267340AbUHPCQU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUHPCQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:16:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:65429 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267340AbUHPCPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:15:02 -0400
Subject: Re: Radeon FB slightly broken in 2.6.8.x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <411FFC3B.9050808@tequila.co.jp>
References: <411F5F7F.9050403@tequila.co.jp>
	 <1092608961.9529.23.camel@gaston>  <411FFC3B.9050808@tequila.co.jp>
Content-Type: text/plain
Message-Id: <1092622048.9529.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 12:07:28 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> |>I am a forced owner of a Radeon 7500 in my Sony Laptop. with 2.6.7 the
> |>framebuffer works perfectly fine, but with 2.6.8.x I get strange
> |>colerful ascii garbage on the bottom of the screen during booten and
> |>then good 10 or more lines are sort of "hidden" outside of the screen.
> |>It seems like the screen is not positioned to the end of the output.
> |>Kinda strange, cause I first thought it stopped loading exim4 for some
> |>reason and not until after I pressed enter a lot I saw that I had a
> |>login screen just very far outside of my visual area :)
> |>
> |>Config attached, but it hasn't chagned to 2.6.7 in the FB area.
> |
> |
> | Does it get back to normal at the end of boot ?
> 
> The "colorful" ascii disappear as they are only ~10 lines and they
> scroll up. But even after login, the actual cursor is ~10-15 lines
> outside of the visible area.

Does it disappear if you use video=radeonfb:noaccel on the kernel
command line ?

Ben.




