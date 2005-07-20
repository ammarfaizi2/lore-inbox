Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVGTEub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVGTEub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 00:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVGTEtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 00:49:36 -0400
Received: from host218.bellglobal.com ([204.101.166.218]:40971 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261733AbVGTEte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 00:49:34 -0400
Date: Wed, 20 Jul 2005 00:27:55 -0400
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (2/9)
Message-ID: <20050720042755.GD26552@kroah.com>
References: <20050719233902.40282559.khali@linux-fr.org> <20050719234843.14cfb1ec.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719234843.14cfb1ec.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 11:48:43PM +0200, Jean Delvare wrote:
> Convert i2c-isa from a dumb i2c_adapter into a pseudo i2c-core for ISA
> hardware monitoring drivers. The isa i2c_adapter is no more registered
> with i2c-core, drivers have to explicitely connect to it using the new
> i2c_isa_{add,del}_driver interface.

Ick, when I did this originally it was a hack, and it's still a hack.
It's sad to see it spreading around, but that's proably my fault...

Anyway, what are your plans for after this?  How long will this code
stay around?  What do you want to do next?

I don't have any real objections to this patch series at all, just very
curious as to your proposed roadmap after this.

thanks,

greg k-h
