Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272525AbTHKMpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272528AbTHKMpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:45:22 -0400
Received: from ANancy-107-1-13-97.w81-48.abo.wanadoo.fr ([81.48.187.97]:49676
	"EHLO xiii.freealter.fr") by vger.kernel.org with ESMTP
	id S272525AbTHKMpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:45:21 -0400
Message-ID: <3F378FC3.1020507@freealter.com>
Date: Mon, 11 Aug 2003 14:44:51 +0200
From: Ludovic Drolez <ludovic.drolez@freealter.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030625
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: keep the linux logo displayed
References: <Pine.LNX.4.44.0307211749400.6905-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0307211749400.6905-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 	You can write a userland app to do this. There are esc sequence 
> that change vc_top. You could even alter minigetty if you want.

Many thanks for the esc sequence hint !
But it seems there's something broken with it: if I send 'esc[10;20r'
- the scrolling region is now between lines 10 and 20
- but, the cursor is moved to 0,0 instead of line 10
- and the linux logo does not appear...

Bug or feature ??

-- 
Ludovic DROLEZ                                       Free&ALter Soft
152, rue de Grigy - Technopole Metz 2000                  57070 METZ
tel : 03 87 75 55 21                            fax : 03 87 75 19 26


