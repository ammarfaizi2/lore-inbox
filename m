Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSFQKKf>; Mon, 17 Jun 2002 06:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSFQKKe>; Mon, 17 Jun 2002 06:10:34 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:24483 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S316883AbSFQKKd>;
	Mon, 17 Jun 2002 06:10:33 -0400
Date: Mon, 17 Jun 2002 12:10:34 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Inexplicable disk activity trying to load modules on devfs
Message-ID: <20020617101034.GA23978@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
References: <20020615172244.C19123@crack.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020615172244.C19123@crack.them.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2002 at 05:22:44PM -0500, Daniel Jacobowitz wrote:
> I just booted into 2.4.19-pre10-ac2 for the first time, and noticed
> something very odd: my disk activity light was flashing at about
> half-second intervals, very regularly, and I could hear the disk

I have a similar problem with the popular 'dig' utility. Running 'dig 2>
/dev/null > /dev/null' suffices to cause disk activity, even when run many
times in succession.

As far as stracing can tell (dig is multithreaded), there is no reason for
this.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
