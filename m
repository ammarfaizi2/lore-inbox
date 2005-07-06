Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVGFAcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVGFAcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 20:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVGFAcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 20:32:15 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:21222 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262024AbVGFAbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 20:31:50 -0400
Message-ID: <42CB2677.8060409@namesys.com>
Date: Tue, 05 Jul 2005 17:31:51 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
CC: David Masover <ninja@slaphack.com>, linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
References: <200507042032.j64KWiY9009684@laptop11.inf.utfsm.cl>	<42CB0A40.3070903@slaphack.com> <877jg4an70.fsf@jbms.ath.cx>	<42CB0F22.5030609@slaphack.com> <87pstw979h.fsf@jbms.ath.cx>
In-Reply-To: <87pstw979h.fsf@jbms.ath.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Maitin-Shepard wrote:

>Okay, so you are suggesting that file-as-dir would provide the user
>interface for enabling the encryption or compression.  Alternatively,
>though, an ioctl could be used to control compression and encryption.
>
>  
>
Why is it that /proc does not use an ioctl?  Use of metafiles could
allow eliminating ioctl(), which most folks I know hate as an
interface.  Wouldn't it be cleaner if we could find out what ioctl()s
are supported by a given file using ls filename/..../ioctl?

Excerpt from the ioctl man page, which lacks a list of what features are
implemented or how to find out.

CONFORMING TO
       No single standard.  Arguments, returns, and semantics of
ioctl(2) vary
       according to the device driver in question  (the  call  is  used 
as  a
       catch-all  for  operations  that  don't cleanly fit the Unix
stream I/O
       model). See ioctl_list(2) for a list of many of the known ioctl 
calls.
       The ioctl function call appeared in Version 7 AT&T Unix.


