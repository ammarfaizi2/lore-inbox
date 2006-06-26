Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933270AbWFZXGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933270AbWFZXGB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933288AbWFZXF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:05:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933265AbWFZXFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:05:54 -0400
Date: Mon, 26 Jun 2006 16:05:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom-killer problem
In-Reply-To: <200606270028.16346.daniel.ritz-ml@swissonline.ch>
Message-ID: <Pine.LNX.4.64.0606261604180.3927@g5.osdl.org>
References: <200606270028.16346.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jun 2006, Daniel Ritz wrote:
>
> reverting the attached patch fixes the problem...

Michal, can you also confirm that just doing a simple revert of that one 
commit makes things work for you?

Sam, if I don't hear otherwise from you, and Michael confirms, I'll just 
revert it for now, and you can figure out how to fix it without breakage?

			Linus
