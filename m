Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVJ3K4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVJ3K4m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 05:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVJ3K4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 05:56:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20392 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932138AbVJ3K4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 05:56:41 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: amd64 bitops fix for -Os
References: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Sun, 30 Oct 2005 08:56:21 -0200
In-Reply-To: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br> (Alexandre
 Oliva's message of "Sat, 29 Oct 2005 19:56:02 -0200")
Message-ID: <orfyqjgtnu.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29, 2005, Alexandre Oliva <aoliva@redhat.com> wrote:

> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171672

> In teh find_first_zero_bit case, this comes at pretty much no cost,
> since we already test size for non-zero, but we used to do that
> adjusting it from bits to words; changing it should have no visible
> effect on performance.

I forgot to mention that this approach to fix the problem was
suggested by Al Viro.  Sorry, Al.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
