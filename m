Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWHIWD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWHIWD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWHIWD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:03:26 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:24995 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751389AbWHIWDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:03:25 -0400
Date: Thu, 10 Aug 2006 00:03:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian McGrew <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Upgrading kernel across multiple machines
Message-ID: <20060809220309.GA14665@mars.ravnborg.org>
References: <C0FFA739.8986%brian@visionpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C0FFA739.8986%brian@visionpro.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 02:52:41PM -0700, Brian McGrew wrote:
> Hello,
> 
> I'm using a Dell PE1800 and I've built a new 2.6.16.16 kernel on the machine
> that works fine.  However, if I tar up /lib/modules/2.6.16.16 and /boot and
> move it onto another Dell PE1800 running the exact same software (FC3/Stock
> install) the new kernel doesn't boot.
> 
> On machine #1 life is good but moving it to machine #2, I get
> 
> /lib/ata_piix.ko: -l unknown symbol in module.
Looks like your kernel modules has ended up in /lib somehow.
Cannot see why atm.

	Sam
