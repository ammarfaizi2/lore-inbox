Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbTIGKTq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 06:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbTIGKTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 06:19:46 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:33692 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263213AbTIGKTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 06:19:45 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 XF86Config-4 mouse resolution doesn't work 
From: Ullrich Jans <ujans@ullisys.pond.sub.org>
Date: Sun, 07 Sep 2003 12:19:35 +0200
Message-ID: <87r82syk7c.fsf@ullisys.pond.sub.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Seen: false
X-ID: V+6+4wZJYemQak7snxZ-MlFjTKi-71MWot9masIW+NVe9PX58Ty7wO@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Hickey (bugfood-ml@fatooh.org) wrote:

> In my XF86Config-4 file, I have my mouse set to use the "Resolution"
> option, in order to have faster pointer motion without using
> acceleration. This worked fine in 2.4.21, but now that I'm trying
> out 2.6.0-test3 it doesn't seem to work. That is, changing the value
> of "Resolution" has no effect whatsoever. The mouse is slow, like it
> used to be in 2.4 before I added the Resolution option.

For me, loading psmouse with the parameter psmouse_resolution=200
helped, like this:

modprobe psmouse psmouse_resolution=200

Hope this helps... 

Regards, Ulli

-- 
Ullrich Jans                           Eichenstrasse 4
Tel: +49 89 74427834                   82024 Taufkirchen
Usenet: ujans@ullisys.pond.sub.org     RealUlli@IRC
