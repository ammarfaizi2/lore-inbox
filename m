Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272258AbTGYTRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272259AbTGYTRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:17:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:22724 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272258AbTGYTRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:17:54 -0400
Date: Fri, 25 Jul 2003 15:32:33 -0400
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, davem@redhat.com, arjanv@redhat.com,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting.
Message-ID: <20030725193233.GA3627@kroah.com>
References: <20030725173900.D7DE12C2A9@lists.samba.org> <20030725122651.4aedc768.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725122651.4aedc768.shemminger@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 12:26:51PM -0700, Stephen Hemminger wrote:
> 
> There are two possible objections to this:
>  * Some developers keep the same kernel running and load/unload then reload
>    a new driver when debugging. This would break probably or at least cause
>    a large amount of kernel growth. Not that big an issue for me personally
>    but driver writers seem to get hit with all the changes.

As a driver writer, I don't mind this.

thanks,

greg k-h
