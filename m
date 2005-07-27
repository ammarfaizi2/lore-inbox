Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVG0Ael@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVG0Ael (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVG0Ac4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 20:32:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262354AbVG0Abx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 20:31:53 -0400
Date: Tue, 26 Jul 2005 17:31:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Marc Ballarin <Ballarin.Marc@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/23] Don't export machine_restart, machine_halt, or
 machine_power_off.
In-Reply-To: <m1oe8p9k0m.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0507261731060.3227@g5.osdl.org>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
 <m1iryxeb4t.fsf@ebiederm.dsl.xmission.com> <m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
 <m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com> <m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
 <m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com> <m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
 <20050727015519.614dbf2f.Ballarin.Marc@gmx.de> <m1oe8p9k0m.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Jul 2005, Eric W. Biederman wrote:
> 
> I suspect a call to panic would be more appropriate there.

Absolutely. Then the sysadmin can say whether they want reboot-on-panic 
behaviour or not.

A filesystem should definitely _not_ decide to reboot the machine. Ever.

		Linus
