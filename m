Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbTDJWKx (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbTDJWKw (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:10:52 -0400
Received: from cs.columbia.edu ([128.59.16.20]:64710 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S264212AbTDJWKn (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:10:43 -0400
Subject: Re: kernel support for non-english user messages
From: Shaya Potter <spotter@cs.columbia.edu>
To: John Bradford <john@grabjohn.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, root@chaos.analogic.com,
       Frank Davis <fdavis@si.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304102036.h3AKa837025670@81-2-122-30.bradfords.org.uk>
References: <200304102036.h3AKa837025670@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1050013215.23204.8.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Apr 2003 18:20:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 16:36, John Bradford wrote:
> > There is a lot of anti-VMS stuff in the Unix world mostly coming
> > from the _horrible_ command line and other bad early memories. There
> > is also a hell of a lot of really cool stuff under that command line
> > we could and should learn from.
> 
> When are we going to see versioned filesystems in Linux?  That was a
> standard feature in VMS.

it shouldn't be that hard, it was one of the 6 OS projects for the
regular 4000 level (senior/grad) level OS class here at columbia last
semster.  

The assignment was to modify ext2 to support versioning, basically means
making a copy of it within ext2's open, if it's opened O_RDWR.  The
assignment was a little bit more complicated in that we took an ext2
flag bit to mean "version", so that a file would only be versioned if
the bit was set, as well as only allowing a single level of versioning,
though extending it w/ more wouldn't be that hard.

The student solutions (as well as our sample solution) weren't that
"pretty", but then again, each project was only for 2-2.5 weeks.

