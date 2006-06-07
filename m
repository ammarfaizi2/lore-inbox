Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWFGA0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWFGA0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWFGA0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:26:35 -0400
Received: from gw.goop.org ([64.81.55.164]:21939 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751401AbWFGA0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:26:34 -0400
Message-ID: <44861D37.7050301@goop.org>
Date: Tue, 06 Jun 2006 17:26:31 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: Andrew Morton <akpm@osdl.org>, Don Zickus <dzickus@redhat.com>, ak@suse.de,
       shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org> <200606070938.34927.ncunningham@linuxmail.org> <44861899.1040506@goop.org> <200606071013.53490.ncunningham@linuxmail.org>
In-Reply-To: <200606071013.53490.ncunningham@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> It's probably safter to say "In the suspend/resume case, they may well be." 
> It's not inconceivable that a system could be suspended, a faulty cpu 
> replaced with another, and the system resumed. Hotplugging ought to handle 
> that nicely.
>   
I think, in general, changing the hardware configuration of the system 
while its suspend is not supported.  But perhaps someone who actually 
knows about this PM stuff has a more authoritative view...

    J
