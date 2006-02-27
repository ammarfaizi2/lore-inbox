Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWB0T6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWB0T6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWB0T6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:58:14 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:31799 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932100AbWB0T6N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:58:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ScfS4YPGsZK4iIEOs8DykX2Do50LRKIuT1xhlbFG+gb+Xcy1l9cVQwZPacNHZlQQ6npFuXebCpI/v8tdb4uIwypFHqUOsNDPco2oXxEVR4I7vJqFBRgPRGv8aBfvawMnSD4ydYeSOmCztkpQdrwgexUzb6r3DZ8o8eHhCv2g1Hc=
Date: Mon, 27 Feb 2006 20:57:59 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, davej@redhat.com, perex@suse.cz, kay.sievers@vrfy.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-Id: <20060227205759.4a7c7c13.diegocg@gmail.com>
In-Reply-To: <20060227194941.GD9991@suse.de>
References: <20060227190150.GA9121@kroah.com>
	<20060227203520.0df1d548.diegocg@gmail.com>
	<20060227194941.GD9991@suse.de>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 27 Feb 2006 11:49:41 -0800,
Greg KH <gregkh@suse.de> escribió:


> An explicit example of this is the evolution that sys_futex went
> through, even after it was made a syscall...

I see...sorry for not explaining myself: Isn't "testing" just an
alias for "unstable"?

I understand that an interface can be in a "testing" stage and at
the same time not be "unstable" (even if "testing" also means it
can change). But shouldn't all the interfaces in "testing" stage
be also "unstable" by default? Or they're just different degrees
of "unstability"? It's a bit confusing IMO
