Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbWBAH44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbWBAH44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbWBAH44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:56:56 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:62584 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030562AbWBAH44 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:56:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jt9jSfkdLZQtuzdzOU8wpZxpShqIPVMOnyJrgwPxj+vx0hY0RHOV/+bl9L3TjfbhUBkW8OzPRuW6hAuEPtE78dDeHwvbJ+6lnGq9Z4k77Fta6fzzQRxg6wDIlNocmUrF0eW5q9kcuF+YJcsl3MWQJOdCJj/WJFmv7LnAzZi0Azo=
Message-ID: <5a2cf1f60601312356n1b031344r11290879d80d5b57@mail.gmail.com>
Date: Wed, 1 Feb 2006 08:56:54 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Albert Cahalan <acahalan@gmail.com>
Subject: Re: CD writing in future Linux try #2
Cc: "David S. Miller" <davem@davemloft.net>, gmack@innerfire.net,
       diablod3@gmail.com, schilling@fokus.fraunhofer.de, bzolnier@gmail.com,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <787b0d920601312049n313364a1q8a41e10c3cda98e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601302043.56615.diablod3@gmail.com>
	 <20060130.174705.15703464.davem@davemloft.net>
	 <Pine.LNX.4.64.0601310609210.2979@innerfire.net>
	 <20060131.031817.85883571.davem@davemloft.net>
	 <787b0d920601312049n313364a1q8a41e10c3cda98e0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Albert Cahalan <acahalan@gmail.com> wrote:
> On 1/31/06, David S. Miller <davem@davemloft.net> wrote:
>
> > Someone remind me why the whole world is a prisoner to Joerg's cd
> > burning program?
> >
> > Anybody can write their own, and if Joerg is a pain to work with that
> > is a double extra incentive for this other implementation to be
> > written.
> >
> > In fact I'm very surprised this hasn't happened already.
>
> It has happened, many times, but sustaining such a project is
> very difficult. The obstacles are numerous:
>
> All the GUI apps parse cdrecord output. The output is somehow
> even messier than the recent /proc/*/smaps abomination. It is
> thus difficult to change or replace cdrecord. One of the major
> GUI apps appears to be written by Joerg's real-life non-Internet
> friend, who naturally refuses any patches to eliminate the need
> for cdrecord.

http://lists.freedesktop.org/archives/libburn/2006-January/000329.html

"Announcing cdrskin, a limited cdrecord compatibility wrapper for libburn

cdrskin currently is able to blank and burn data CDs with one or more
tracks. [...]

I am using cdrskin daily with my data backups on CD-RW where it shows about
the same reliability as cdrecord-ProDVD 2.01b31. The backup success is verified
by my backup tool via a MD5 stream checksum.

This is the initial public release 0.1.0 of cdrskin. [...]"

see also http://icculus.org/burn/

Jerome
