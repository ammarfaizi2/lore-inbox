Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271415AbTGXJTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 05:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271416AbTGXJTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 05:19:52 -0400
Received: from ANancy-107-1-22-138.w81-49.abo.wanadoo.fr ([81.49.204.138]:53512
	"EHLO xiii.freealter.fr") by vger.kernel.org with ESMTP
	id S271415AbTGXJTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 05:19:38 -0400
Message-ID: <3F1FA7D6.5030305@freealter.com>
Date: Thu, 24 Jul 2003 11:33:10 +0200
From: Ludovic Drolez <ludovic.drolez@freealter.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: linux-kernel@vger.kernel.org
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

