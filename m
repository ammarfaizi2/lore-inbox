Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWGJNSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWGJNSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWGJNSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:18:55 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:6662 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751355AbWGJNSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:18:53 -0400
Message-ID: <44B253BA.3030103@superbug.co.uk>
Date: Mon, 10 Jul 2006 14:18:50 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
CC: Lee Revell <rlrevell@joe-job.com>, alan@lxorguk.ukuu.org.uk,
       alsa-devel@alsa-project.org, ak@suse.de, perex@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>	<1152458300.28129.45.camel@mindpipe> <20060710132810.551a4a8d.atlka@pg.gda.pl>
In-Reply-To: <20060710132810.551a4a8d.atlka@pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Tla³ka wrote:
> We have also almost no docs about ALSA drvier <-> ALSA lib interface which is a strange
> in case of GPL'ed software if we want to implement a new hw driver.
>
>   
To implement a new hw driver, one does not need to know anything about 
the ALSA driver <-> ALSA lib interface.
One simply implements a small set of functions, and ALSA does the rest.
There is good documentation regarding what this small set of functions 
are and what they should do.

James

