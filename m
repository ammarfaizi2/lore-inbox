Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965387AbWIRFD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965387AbWIRFD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 01:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965388AbWIRFD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 01:03:56 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:59711 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965387AbWIRFDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 01:03:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tCWamr8ybMEjxTh6mKIbuxGQChTUI1wNHrxVdJlJvX+8+VylDjCX3D7KSBM89ZyfxAQr9J7O7zj0SGZe56WDDP6ig6qhUWu6gRz3W5cb2oWwtaMe8tyOiIYf9uyTdtIjtw7PtSb/EGIipJrHDpw0/GENNCObM3GmAJFZJkFMbjI=
Message-ID: <20f65d530609172203o566ab327i6ca5bb9817d905a4@mail.gmail.com>
Date: Mon, 18 Sep 2006 17:03:55 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Crash on boot after abrupt shutdown
In-Reply-To: <1158528078.6069.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530609161930m2311974esfeaa2fbc2592e49f@mail.gmail.com>
	 <1158528078.6069.70.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan

> Very unlikely but you don't provide enough information to even guess.
>
> I've seen similar behaviours before and they usually indicate a bug in
> the driver that crashed. Eg the setup code for a network card not being
> able to cope if the network card is in a particular state but does
> enough that next boot it works.
>
> You need to work back from your wireless driver panic to the root cause
> of that panic and then back from there.
>

Thank you very much for your diagnostic. The stack traces are not as
consistent as our driver crashes, so we have not posted them yet
before digging a bit deeper. We are now looking at the
startup/shutdown process of the driver, and there could be some
critical timing issues, but we will check and test.

Thanks again, will report back soon.

Regards
Keith
