Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbTI2R3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTI2RXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:23:06 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:8198 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263883AbTI2RWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:22:51 -0400
Date: Mon, 29 Sep 2003 19:22:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Smurf <smurf@play.smurf.noris.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] No forced rebuilding of ikconfig.h
Message-ID: <20030929172249.GA1815@mars.ravnborg.org>
Mail-Followup-To: Smurf <smurf@play.smurf.noris.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20030929153815.GA16685@play.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929153815.GA16685@play.smurf.noris.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 05:38:15PM +0200, Smurf wrote:
> Why does ikconfig.h require forced rebuilding?
> I can't think of a reason...

Check Documentation/kbuild/makefiles.txt, search for if_changed.

	Sam
