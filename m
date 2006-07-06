Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWGFALP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWGFALP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWGFALP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:11:15 -0400
Received: from terminus.zytor.com ([192.83.249.54]:64939 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965072AbWGFALO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:11:14 -0400
Message-ID: <44AC551B.8090204@zytor.com>
Date: Wed, 05 Jul 2006 17:11:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <klibc.200606272217.30@tazenda.hos.anvin.org> <200607060940.40678.ncunningham@linuxmail.org>
In-Reply-To: <200607060940.40678.ncunningham@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> 
> This patch doesn't look right to me. After it is applied, the user will have 
> no way of saying that they don't want to resume (noresume). I assume the 
> removal of resume= isn't a problem because you're expecting them to use that 
> other undocumented way of setting resume= that Pavel mentioned a while ago?
> 

Yes, they have.  The handing of resume= and noresume are now done in 
kinit; resume is invoked from userspace by direct command only.

There is nothing undocumented about it.

	-hpa
