Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTJ0TeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTJ0TeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:34:24 -0500
Received: from pushme.nist.gov ([129.6.16.92]:21160 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id S263470AbTJ0TeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:34:23 -0500
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: APM suspend still broken in -test9
References: <3F9D62DD.9020503@pacbell.net>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Mon, 27 Oct 2003 14:33:45 -0500
In-Reply-To: <3F9D62DD.9020503@pacbell.net> (David Brownell's message of
 "Mon, 27 Oct 2003 10:24:29 -0800")
Message-ID: <9cffzhezd9i.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, that patch solves it for me, and applies cleanly to -test9.
Ian

David Brownell <david-b@pacbell.net> writes:

> Those are the same symptoms I saw in test7, fixed by:
>
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=106606272103414&w=2
>
> Patrick, were you going to submit your patch to resolve this?
> I'm thinking this kind of problem would meet Linus's test10
> integration criteria.
>
> (That's not an APM problem, it's a generic PM problem that'd
> show up with swsusp too.  And likely even some ACPI systems.)
>
> - Dave

