Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTJ0VAf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTJ0VAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:00:34 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:45013 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263595AbTJ0VA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:00:26 -0500
Message-ID: <3F9D875E.8020302@blue-labs.org>
Date: Mon, 27 Oct 2003 16:00:14 -0500
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Mock <kd6pag@qsl.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test9 suspend problems
References: <E1AEEKl-0000yc-00@penngrove.fdns.net>
In-Reply-To: <E1AEEKl-0000yc-00@penngrove.fdns.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately I use USB mostly for my digital camera.  Losing sound is 
pretty annoying too because everything that tries to play sound then 
gets into D state as well.

John Mock wrote:

>Software suspend failing with 'uhci-hcd' is a known problem under 2.6.0
>(see Bug #1373):
>
>    http://www.ussg.iu.edu/hypermail/linux/kernel/0308.0/1805.html
>    http://www.ussg.iu.edu/hypermail/linux/kernel/0308.0/1867.html
>    http://bugzilla.kernel.org/show_bug.cgi?id=1373
>
>It was reported a while ago (in 2.5.73-mm1):
>
>    http://www.ussg.iu.edu/hypermail/linux/kernel/0306.3/1093.html
>
>According to current release critera, it seems that most software-suspend
>related issues will have to wait until after 2.6.0 is released in terms
>of the regular kernel. (Maybe a private patch might be available sooner.)
>
>If your only USB devices are mice and/or keyboards, then you can probably
>put a 'rmmod uhci-hcd'/'modprobe uhci-hcd' pair in your hiberation script.
>
>That fix is unlikely to work for things like file-oriented devices (such 
>as digital cameras).
>				-- JM
>  
>

