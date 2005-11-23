Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVKWUE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVKWUE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVKWUE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:04:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:62429 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932282AbVKWUEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:04:25 -0500
Date: Wed, 23 Nov 2005 12:03:34 -0800
From: Greg KH <gregkh@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: Eduardo Pereira Habkost <ehabkost@mandriva.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       akpm@osdl.org
Subject: Re: [PATCH 2/2] - usbserial: race-condition fix.
Message-ID: <20051123200334.GC29181@suse.de>
References: <20051122195926.18c3221c.lcapitulino@mandriva.com.br> <20051122221353.GA10311@suse.de> <20051123093655.5555f23e.lcapitulino@mandriva.com.br> <20051123115633.GS14440@duckman.conectiva> <20051123100708.6319df27.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123100708.6319df27.lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 10:07:08AM -0200, Luiz Fernando Capitulino wrote:
>  Since the spinlock seems to be only used to protect 'write_urb_busy', I agree
> with those changes.
> 
>  Greg, do you? If so, I suggested we should add the semaphore first, because
> it is a bug fix.

Yes, I agree.

>  I can do the 'write_urb_busy' type replace next week (yes, I will replace all
> the drivers).

Ok, that sounds fine.

thanks,

greg k-h
