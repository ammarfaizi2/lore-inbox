Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272253AbTGYS4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272254AbTGYS4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:56:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:20160 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272253AbTGYS4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:56:47 -0400
Date: Fri, 25 Jul 2003 15:11:47 -0400
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davem@redhat.com, arjanv@redhat.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting.
Message-ID: <20030725191147.GA3059@kroah.com>
References: <20030725173900.D7DE12C2A9@lists.samba.org> <20030725175447.GB2410@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725175447.GB2410@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 01:54:47PM -0400, Greg KH wrote:
> 
> Can we still prevent this from happening now?  I think if we add a
> kobject (or something, we still need a kobject to get module
> parameters so might as well use that), we might be safe.

Ok, in talking to you in person I now understand this better, the code
doesn't go away at all.  That sounds fine, I have no problem with this
change.

thanks,

greg k-h
