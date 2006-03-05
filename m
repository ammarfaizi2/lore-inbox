Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWCEVaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWCEVaZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbWCEVaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:30:25 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:26513 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751817AbWCEVaY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:30:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jDC2gXXjkDK8uBJ3lZeeiNEZRoVu5LnpqJytmJKHf9Fx0/1oEgOcshi1Pu8T4qPJUs3/Gx++M9xVd+A+sSGIK3NE3qH7foW6LQlrjA7KgovQyEsK8UXEDt85ZmKXEqGlFYWLnATfOedIyIUzA9xewao3CLnoYajNatyaxLTjiGU=
Message-ID: <35fb2e590603051330o1dfa6951le3e7f14cda0c0eaa@mail.gmail.com>
Date: Sun, 5 Mar 2006 21:30:24 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "=?ISO-8859-1?Q?Ra=FAl_Baena?=" <raul_baena@ya.com>
Subject: Re: Doubt about scheduler
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <440B01E1.8080102@ya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4407584A.60301@ya.com>
	 <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com>
	 <440AE3F3.3090404@ya.com> <440AE7E3.4060500@yahoo.com.au>
	 <440B01E1.8080102@ya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/06, Raúl Baena <raul_baena@ya.com> wrote:

> I thought that to make the module about the new O(k) scheduler would be
> a good idea. I think that it´s not enough for me schedstats, because I
> want to make a visual scheduler, I mean, using GTK+ , a module and
> something else to make a visual scheduler monitor, how the tasks move
> between "active" and "expired", where the task are in prio_array with
> the bitmap fields...this module isn´t usefull, only in a didactic way.

If you're seriously interested in this then cool. Let me know how you get on.

I looked at hacking something into gtop etc. previously to use
/proc/kcore and pull out task information - I'd certainly like to see
a visual process monitor that could pull all of this stuff out and
display it for educational interest (page tables, vmas, other
resources). But then, it's probably been done - I didn't look to see
what else is out there.

Jon.
