Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285197AbRLRVgO>; Tue, 18 Dec 2001 16:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLRVed>; Tue, 18 Dec 2001 16:34:33 -0500
Received: from mout1.freenet.de ([194.97.50.132]:65475 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S285203AbRLRVde>;
	Tue, 18 Dec 2001 16:33:34 -0500
Message-ID: <3C1FB6A0.5080908@athlon.maya.org>
Date: Tue, 18 Dec 2001 22:35:28 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeronimo Pellegrini <pellegrini@mpcnet.com.br>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17rc1] fatal problem: system time suddenly changes
In-Reply-To: <Pine.LNX.4.21.0112181509150.4456-100000@freak.distro.conectiva> <3C1F901E.6050800@athlon.maya.org> <20011218195245.GA28160@socrates>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeronimo Pellegrini wrote:

> Hi.
> 
> That's a VIA timer bug. The patch that fixes it was inthe kernel some
> time ago, but was removed because the workaround was being triggered
> when it shouldn't, if I remember correctly.


Thank you! I applied the patch and did a first quick and dirty test. 
After 20 restarts of X I coludn't detect any problem :-).

I will do a long term test from now on in order to see, if the problem 
appears again.

Is there a chance to get this patch in in vanilla kernel (maybe with 
some changes), if it really fixes the VIA timer bug?

Regards,
Andreas

