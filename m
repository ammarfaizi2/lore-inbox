Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUJ3Vge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUJ3Vge (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUJ3Vge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:36:34 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:4376 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261340AbUJ3Ve5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:34:57 -0400
Date: Sun, 31 Oct 2004 01:35:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: get a pointer to $(obj)/../../include/asm/byteorder.h
Message-ID: <20041030233543.GG9592@mars.ravnborg.org>
Mail-Followup-To: Olaf Hering <olh@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20041020185355.GA11861@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020185355.GA11861@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 08:53:55PM +0200, Olaf Hering wrote:
> Sam,
> 
> drivers/atm/Makefile looks a bit messy..
> 
> Is there a way to get $(obj)/include2/asm/byteorder.h?
> make all O=$foo fails to set the correct byteorder for
> CONFIG_ATM_FORE200E_PCA_FW when CONFIG_ATM_FORE200E_PCA_DEFAULT_FW is
> set.

Right fix is to introduce the firmware loader stuff.
I've deliberatly not fixed this up for that reason.

	Sam
