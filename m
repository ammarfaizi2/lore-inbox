Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131681AbRCSXaa>; Mon, 19 Mar 2001 18:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131692AbRCSXaN>; Mon, 19 Mar 2001 18:30:13 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:57865 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S131681AbRCSX3I>; Mon, 19 Mar 2001 18:29:08 -0500
Message-ID: <3AB695DE.84A933D@vc.cvut.cz>
Date: Tue, 20 Mar 2001 00:27:26 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
Organization: Czech Technical University - Computing and Information Centre
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: cs,cz,en
MIME-Version: 1.0
To: elmer@linking.ee
CC: linux-kernel@vger.kernel.org
Subject: Re: atyfb,matrox hardlocks, multihead, USB broken, 2.4.2-ac8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot to CC linux kernel...

Elmer Joandi wrote:
> 
> 2.4.2-ac8, with 4 graphics cards, Dual Celeron
> now with 2.4.2-ac8 it is even more clear
> any attempt to insert  module ends with straight lockup
> video mode swithc occurs and then ping to the box stops
> immediately.
> more, starting X locks kernel the same way.

Try 'video=scrollback:0'. Scrollback code does not handle
heads with different width correctly.
						Petr Vandrovec
