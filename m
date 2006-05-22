Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWEVKzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWEVKzD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWEVKzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:55:03 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:51854 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750710AbWEVKzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:55:01 -0400
Date: Mon, 22 May 2006 12:54:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: Michael Buesch <mb@bu3sch.de>, Pau Garcia i Quiles <pgquiles@elpauer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
In-Reply-To: <44717424.4020705@argo.co.il>
Message-ID: <Pine.LNX.4.61.0605221253300.10051@yvahk01.tjqt.qr>
References: <200605212131.47860.pgquiles@elpauer.org> <20060521193803.GG8250@redhat.com>
 <200605212146.30342.mb@bu3sch.de> <44717424.4020705@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You really want a system, which freezes for 10-20 seconds every 5 minutes,
>> and thaws again when the image is written?
>
> The snapshot could be taken in the background, by marking all pages read-only,
> starting a thread to write them to disk, and continuing normal processing.
>
> Such systems have been implemented in the past, see for example
> http://www.eros-os.org/.
>

Another one is VMware's background snapshot feature. Granted, it writes
"quite much" (IMO) to disk, but it's better than a foreground snapshot. :)


Jan Engelhardt
-- 
