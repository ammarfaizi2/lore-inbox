Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbTDLJLm (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 05:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbTDLJLm (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 05:11:42 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:61930 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S263209AbTDLJLl (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 05:11:41 -0400
Date: Sat, 12 Apr 2003 11:23:49 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple Kernel-User Event Interface (Was: RE: [ANNOUNCE] udev 0.1 release)
Message-ID: <20030412092349.GB1542@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	linux-kernel@vger.kernel.org
References: <A46BBDB345A7D5118EC90002A5072C780BEBAB31@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBAB31@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 01:52:38AM -0700, Perez-Gonzalez, Inaky wrote:
> 
> The idea of allowing multiple readers was so you can have other actors
> listening for stuff - although the main one would always be the event
> daemon (that could even forward the events).

I think multiple readers is a good idea. Though it can be (ab)used to
create inefficient solutions (hundreds of listeners each handling their
own particular event) it is very practical as it makes it possible
to add an event handler without having to dig into the hotplug script
infrastructure or depending on that.

-- 
Frank
