Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbTAUO3L>; Tue, 21 Jan 2003 09:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbTAUO3L>; Tue, 21 Jan 2003 09:29:11 -0500
Received: from pc-62-31-74-42-ed.blueyonder.co.uk ([62.31.74.42]:44673 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S267090AbTAUO3K>; Tue, 21 Jan 2003 09:29:10 -0500
Subject: Re: 2.4.21-pre3 - problems with ext3 (long)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Bartlomiej Solarz-Niesluchowski 
	<B.Solarz-Niesluchowski@wsisiz.edu.pl>
Cc: Lukasz Trabinski <lukasz@wsisiz.edu.pl>, akpm@zip.com.au,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
In-Reply-To: <5.2.0.9.0.20030121152101.02c1e740@oceanic.wsisiz.edu.pl>
References: <Pine.LNX.4.51.0301210029010.30053@oceanic.wsisiz.edu.pl>
	<Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
	<1043102297.13050.59.camel@sisko.scot.redhat.com>
	<Pine.LNX.4.51.0301210029010.30053@oceanic.wsisiz.edu.pl> 
	<5.2.0.9.0.20030121152101.02c1e740@oceanic.wsisiz.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Jan 2003 14:38:13 +0000
Message-Id: <1043159893.2424.59.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2003-01-21 at 14:22, Bartlomiej Solarz-Niesluchowski wrote:
> At 13:56 2003-01-21 +0000, Stephen C. Tweedie wrote:
> 
> >If that happens again, serial console is the best way of getting the
> >full oops.  How much memory does your system have?  Have you ever seen
> >this error before?
> 
> Yes - we have seen this error before.....

Well, the kmap() bug looks like kunmap() being done twice on a page.  If
that's happening, we really do need to find out where, so capturing that
trace via serial console would be a _big_ help, thanks.

Cheers,
 Stephen

