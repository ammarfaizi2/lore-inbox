Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbUKXKHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbUKXKHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbUKXKG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:06:59 -0500
Received: from colino.net ([213.41.131.56]:51960 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262590AbUKXKGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:06:42 -0500
Date: Wed, 24 Nov 2004 11:06:04 +0100
From: Colin Leroy <colin@colino.net>
To: Raj <inguva@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Delay in unmounting a USB pen drive
Message-ID: <20041124110604.58828db5@pirandello>
In-Reply-To: <b2fa632f04112401525be8b88b@mail.gmail.com>
References: <b2fa632f041124012543876b61@mail.gmail.com>
	<20041124103816.0a8d4183@pirandello>
	<b2fa632f04112401525be8b88b@mail.gmail.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs166.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 2004 at 15h11, Raj wrote:

Hi, 

> > Lucky you :) If your key is fat or vfat, you could try these two patches
> > and mount your USB key with -o sync option, your feedback interests me.
> > It should make the copies to key slower, but the umount immediate.
> 
> Yes, my key is vfat. I shall try out the vfat patch & post the
> results. It might take some time, coz i am building a 2.9 gnome right 
> now. Will keep the list posted with the results.

Apply also the fat patch, vfat uses fat.

-- 
Colin
