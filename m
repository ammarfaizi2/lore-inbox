Return-Path: <linux-kernel-owner+w=401wt.eu-S932972AbWLTFkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932972AbWLTFkG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 00:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932979AbWLTFkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 00:40:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:58526 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932972AbWLTFkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 00:40:04 -0500
X-Authenticated: #14349625
Subject: Re: BUG: wedged processes, test program supplied
From: Mike Galbraith <efault@gmx.de>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <787b0d920612191846t5a51a2e4ld4101b26ca7a8413@mail.gmail.com>
References: <787b0d920612191846t5a51a2e4ld4101b26ca7a8413@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 06:40:00 +0100
Message-Id: <1166593200.1614.8.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 21:46 -0500, Albert Cahalan wrote:
> Somebody PLEASE try this...

I was having enough fun with cloninator (which was whitespace munged
btw).

> Normally, when a process dies it becomes a zombie.
> If the parent dies (before or after the child), the child
> is adopted by init. Init will reap the child.
> 
> The program included below DOES NOT get reaped.

While true wasn't a great test recommendation :)

	-Mike

