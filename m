Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbUDPQra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUDPQra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:47:30 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:51215 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263394AbUDPQrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:47:05 -0400
Date: Fri, 16 Apr 2004 18:55:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Axel Weiss <aweiss@informatik.hu-berlin.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: compiling external modules
Message-ID: <20040416165531.GB2387@mars.ravnborg.org>
Mail-Followup-To: Axel Weiss <aweiss@informatik.hu-berlin.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200404152305.49456.aweiss@informatik.hu-berlin.de> <20040415215907.GD2656@mars.ravnborg.org> <200404161406.17241.aweiss@informatik.hu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404161406.17241.aweiss@informatik.hu-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 02:06:17PM +0200, Axel Weiss wrote:
> 
> *** Warning: "adc64_count" [/home/axel/freeSP-1.0.4/drivers/linux/adc64/
> driver/adc64.ko] undefined!
> *** Warning: "release_adc64_busmaster" [/home/axel/freeSP-1.0.4/drivers/linux/
> adc64/driver/adc64.ko] undefined!
> *** Warning: "get_adc64_busmaster" [/home/axel/freeSP-1.0.4/drivers/linux/
> adc64/driver/adc64.ko] undefined!

modpost was fixed to actually report undefined symbols.
Previously this was only done during modules_install - so much earlier
warning.

	Sam
