Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbRGLFIq>; Thu, 12 Jul 2001 01:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbRGLFIf>; Thu, 12 Jul 2001 01:08:35 -0400
Received: from otter.mbay.net ([206.40.79.2]:45062 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S267430AbRGLFIZ> convert rfc822-to-8bit;
	Thu, 12 Jul 2001 01:08:25 -0400
From: jalvo@mbay.net (John Alvord)
To: linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
Date: Thu, 12 Jul 2001 05:08:25 GMT
Message-ID: <3b512f43.30115420@mail.mbay.net>
In-Reply-To: <Pine.GSO.4.21L-021.0107120031570.7765-100000@unix14.andrew.cmu.edu>
In-Reply-To: <Pine.GSO.4.21L-021.0107120031570.7765-100000@unix14.andrew.cmu.edu>
X-Mailer: Forte Agent 1.5/32.451
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2001 00:48:15 -0400 (EDT), Frank Davis
<fdavis@andrew.cmu.edu> wrote:

>Hello all,
>  I believe that if such a project is to be undertaken, it first
>needs to be designed, then coded. I agree that is a difficult problem...As
>for its feasiblity, I'm unsure. Maybe the reason this topic comes up
>here from time to time is because it hasn't been shown to be a bad
>idea. It might be be, but if we don't start somewhere, then we'll never
>really know, and the debate will continue. Just my .02 cents.
>Regards,

This topic comes up once a twice a year.

Usually this topic comes to a grinding halt when someone points out
that drivers can be created modular. They can be loaded and unloaded
without rebooting Linux. One project used that technique to
load/unload different schedulers. While this satisfies only part of
the need, it is usually enough to satisfy the tinker-er.

A more recent development is UML - User Mode Linux - where you can run
a nearly complete Linux image in user mode. That way you can fiddle
with file systems to your hearts content without rebooting the main
system. I suspect that will satisfy others.

john alvord
