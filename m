Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265689AbUEZNkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUEZNkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265687AbUEZNkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:40:05 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:65005 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S265689AbUEZNiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:38:03 -0400
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Subject: Re: why swap at all?
Date: Wed, 26 May 2004 06:41:17 -0700
User-Agent: KMail/1.6.51
Cc: Matthias Schniedermeyer <ms@citd.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <20040526123740.GA14584@citd.de> <1085576794.20025.5.camel@sherbert>
In-Reply-To: <1085576794.20025.5.camel@sherbert>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405260641.17443.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe it was a 2.4 patch , its still around somewhere. I can find it and 
post it , if it's still relevant. 

Matt H.

On Wednesday 26 May 2004 6:06 am, Gianni Tedesco wrote:
> On Wed, 2004-05-26 at 13:37, Matthias Schniedermeyer wrote:
> > On Wed, May 26, 2004 at 09:19:40PM +1000, Nick Piggin wrote:
> > > Matthias Schniedermeyer wrote:
> > > >On Wed, May 26, 2004 at 08:33:28PM +1000, Nick Piggin wrote:
> > >
> > > OK, this is obviously bad. Do you get this behaviour with 2.6.5
> > > or 2.6.6? If so, can you strace the program while it is writing
> > > an ISO? (just send 20 lines or so). Or tell me what program you
> > > use to create them and how to create one?
> >
> > To use other words, this is the typical case where a "hint" would be
> > useful.
> >
> > program to kernel: "i read ONCE though this file caching not useful".
>
> Wasn't their an O_STREAMING patch thrown around towards the beginning of
> the 2.5 development cycle?
