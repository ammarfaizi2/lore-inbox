Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVHIFqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVHIFqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVHIFqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:46:15 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:4577 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932293AbVHIFqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:46:14 -0400
Subject: Re: Hang at resume with AC adapter not plugged
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christian Hesse <mail@earthworm.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
In-Reply-To: <200508090741.29149.mail@earthworm.de>
References: <200508090741.29149.mail@earthworm.de>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123566339.4370.131.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Aug 2005 15:45:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian.

On Tue, 2005-08-09 at 15:41, Christian Hesse wrote:
> Hi everybody,
> 
> I have a little problem with software suspend 2.1.9.1[012] on 2.6.13-rc[3456]. 
> The system hangs on resume if the AC adapter is not plugged in. Everything 
> works well if I use 2.1.9.5 on 2.6.12.x or plug in the AC adapter. I've tried 
> acpi-20050729 for 2.6.13-rc6 but that did not change anything. The system is 
> a Sumsung X10.
> 
> Any ideas what could be the problem?

Do you have the ACPI modules compiled in, or built as modules? I'd
suggest that you try building them as modules and unloading while
suspending if you're not doing that already.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

