Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271157AbTGPWea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271170AbTGPWe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:34:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:18157 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271157AbTGPWe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:34:26 -0400
Date: Wed, 16 Jul 2003 15:48:38 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what's left for 64 bit dev_t
Message-ID: <20030716224838.GA3362@kroah.com>
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org> <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org> <20030716213607.GA2773@kroah.com> <20030716150010.6ba8416f.akpm@osdl.org> <20030716221154.GA3051@kroah.com> <20030716151939.1762a3cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716151939.1762a3cf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 03:19:39PM -0700, Andrew Morton wrote:
> 
> I expect we'll end up just jamming it in and seeing what happens.

Sounds good to me :)

I think the big problems will start to happen when people try to _use_
the expanded namespace.  Is LANANA set up to assign bigger numbers now?
Are they going to carve them up into chunks?  Or are we relying on
userspace implementations like udev to handle the number management?

greg k-h
