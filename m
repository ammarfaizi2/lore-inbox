Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275304AbTHMSbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275316AbTHMSbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:31:23 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:33802 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275304AbTHMSbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:31:22 -0400
Message-ID: <3F3A8766.9050909@techsource.com>
Date: Wed, 13 Aug 2003 14:45:58 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Voluspa <lista1@telia.com>
CC: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: WINE + Galciv + 2.6.0-test3-mm1-O15
References: <20030812172358.5afe0cc1.lista1@telia.com>	<200308130715.23046.kernel@kolivas.org> <20030813025428.3569ffbc.lista1@telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Voluspa wrote:

> When the blackout starts I no longer have to move the mouse, it is
> enough to hold down the button. The second I release it, the music
> returns.


I think this sort of thing has been discussed before.  I get the 
impression that xmms blocks on the X server, so when some app grabs the 
server, then xmms gets blocked and stops.  I don't know why the display 
code is not in a separate thread from the audio code; although maybe 
they are but they interact somehow that causes this.


