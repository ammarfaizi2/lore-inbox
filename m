Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278509AbRJVLEr>; Mon, 22 Oct 2001 07:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278510AbRJVLE2>; Mon, 22 Oct 2001 07:04:28 -0400
Received: from t2.redhat.com ([199.183.24.243]:1015 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S278509AbRJVLES>; Mon, 22 Oct 2001 07:04:18 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <NPHLGxZPH$07EwlQ@wookie.demon.co.uk> 
In-Reply-To: <NPHLGxZPH$07EwlQ@wookie.demon.co.uk> 
To: John Beardmore <wookie@wookie.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ISDN cards and SMP 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Oct 2001 11:56:50 +0100
Message-ID: <4947.1003748210@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


wookie@wookie.demon.co.uk said:
>  This works fine with a single processor kernel, but the module fails
> to load with a kernel compiled for SMP.

> I gather this is true for all the Isdn4Linux drivers, though as I have
> a three processor machine, this is a real pain !

The HiSax driver should be fine - I use it 100% of the time (or at least
100% of the time we have power to the house) on my SMP box at home, without 
trouble. I see no reason why the other drivers would have problems.

If you're having problem with modules loading, there's probably a
compilation problem. If you're using a distro kernel, check it's installed
properly. If you're building your own, rebuild it and the modules.

--
dwmw2


