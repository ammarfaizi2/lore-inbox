Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVJEU6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVJEU6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVJEU6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:58:47 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:31041 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750832AbVJEU6q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:58:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Krc6G2D1azQLWyhvG2gDiuiTYKfYzUwbvaXfpNPjFFdxzG3oNysxQDHi3MFh/bom3MRLndYyqY44jsWDWTZH2pkC9n03OnbXo5u6FNPADnml78KUvV9ZDF+ETuQdIo8yKz2HAoaL595z5vhPuWhSHAoSIMRXv5CA8vl7p9uUUSM=
Message-ID: <161717d50510051358q3da37e9en22c2f85e2fa7c7ef@mail.gmail.com>
Date: Wed, 5 Oct 2005 16:58:45 -0400
From: Dave Neuer <mr.fred.smoothie@pobox.com>
Reply-To: Dave Neuer <mr.fred.smoothie@pobox.com>
To: Marc Perkel <marc@perkel.com>
Subject: Re: what's next for the linux kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43442D19.4050005@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	 <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
	 <4343E611.1000901@perkel.com>
	 <20051005144441.GC8011@csclub.uwaterloo.ca>
	 <4343E7AC.6000607@perkel.com>
	 <20051005153727.994c4709.fmalita@gmail.com>
	 <43442D19.4050005@perkel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/05, Marc Perkel <marc@perkel.com> wrote:
>
> What you don't get is that if you don't have rights to write to a file
> then you shouldn't have the right to delete the file.  Once you get past
> the "inside the box" Unix thinking you'll see the logic in this. So what
> if the process of deleting a file involves writing to it. That's not
> relevant.
>

No. Listen to what other people are saying. If you have the right to
_create_ the file, you have the right to _delete_ the file. In one
case you are changing the state of where something is stored --
leaving your report on a desk. Changing the contents of the report is
different.

You may not like this paradigm, but it is the Unix/POSIX paradigm and
Linux is not going to suddenly ditch it because it doesn't fit the way
you think permissions should work. As others (and you yourself) have
pointed out, there are other mechanisms in Linux to build additional
policy layers above the basic FS semantics. If you care this much
about the issue, write your own filesystem w/ its own enhanced
permissions scheme, but stop asking the Linux development community to
morph its _Unix-like_ operating system into something else and
insisting everyone who doesn't share your subjective point of view is
ignorant.

Dave
