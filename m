Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269160AbUJTWgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269160AbUJTWgV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269112AbUJTWdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:33:43 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:15171 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S269160AbUJTTtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:49:13 -0400
Date: Wed, 20 Oct 2004 23:50:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Russell Miller <rmiller@duskglow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [MAKE/INSTALL] install bug
Message-ID: <20041020215004.GA9106@mars.ravnborg.org>
Mail-Followup-To: Russell Miller <rmiller@duskglow.com>,
	linux-kernel@vger.kernel.org
References: <200410191159.32754.rmiller@duskglow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410191159.32754.rmiller@duskglow.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:59:32AM -0500, Russell Miller wrote:
> As of 2.6.8.1, there was a small bug in the makefile.  To reproduce:  
> 
> Build a modules enabled kernel.
> Make sure /lib/modules/2.6.whatever doesn't exist
> Run make install.
> It won't create the /lib/modules/2.6.whatever directory until you run make 
> modules_install.
> 
> I think either:
> It should tell you to run make modules_install first
> or it should do it automatically.

Thats actually a bug in your distribution supplied installkernel script -
and outside the control of the kernel.

	Sam
