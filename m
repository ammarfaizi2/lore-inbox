Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281278AbRKETAa>; Mon, 5 Nov 2001 14:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281280AbRKETAV>; Mon, 5 Nov 2001 14:00:21 -0500
Received: from mnh-1-11.mv.com ([207.22.10.43]:60166 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S281279AbRKETAJ>;
	Mon, 5 Nov 2001 14:00:09 -0500
Message-Id: <200111052018.PAA03082@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification 
In-Reply-To: Your message of "Mon, 05 Nov 2001 17:53:37 +0100."
             <20011105175337.D18319@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Nov 2001 15:18:42 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrea@suse.de said:
> O_DIRECT is synchronous but only in terms of data, if you want the
> metadata to be synchronous as well you need to open with
> O_SYNC|O_DIRECT, and even in such case all the metadata reads will
> came from cache. 

That's OK.  The goal is to cram as many UMLs onto a host as possible by
eliminating caching as much as possible.  If the metadata/data ratio is
small, then the metadata caching probably won't be noticable.

				Jeff

