Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWAUX7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWAUX7D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWAUX7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:59:03 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:38920 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S1751236AbWAUX7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:59:02 -0500
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
References: <20060119030251.GG19398@stusta.de>
	<200601211826.02159.gene.heskett@verizon.net>
	<1137886206.11722.1.camel@mindpipe>
	<200601211853.56339.gene.heskett@verizon.net>
From: Doug McNaught <doug@mcnaught.org>
Date: Sat, 21 Jan 2006 18:59:00 -0500
In-Reply-To: <200601211853.56339.gene.heskett@verizon.net> (Gene Heskett's
 message of "Sat, 21 Jan 2006 18:53:56 -0500")
Message-ID: <87bqy5m8u3.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

>>No, it's a different raw driver, for big databases that basically want
>>their own custom filesystem on a disk.
>
> With the attendent possibility of rendering the whole thing 
> unrecoverably moot?
>
> OTOH, if this database actually does have a better way, and its mature 
> and proven, then I see no reason to cripple the database people just to 
> remove what is viewed as a potentially dangerous path to the media 
> surface for the unwashed to abuse.

The database people have a newer and supported way to do that, via the
O_DIRECT flag to open().  They aren't losing any functionality.

-Doug
