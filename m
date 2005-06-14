Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVFNJFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFNJFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 05:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFNJFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 05:05:15 -0400
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:60638 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261154AbVFNJFJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 05:05:09 -0400
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>
	<f192987705061310385260ca06@mail.gmail.com>
	<yw1xekb69j9g.fsf@ford.inprovide.com>
	<200506141404.06888.patrakov@ums.usu.ru>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Tue, 14 Jun 2005 11:05:05 +0200
In-Reply-To: <200506141404.06888.patrakov@ums.usu.ru> (Alexander E.
 Patrakov's message of "Tue, 14 Jun 2005 14:04:06 +0600")
Message-ID: <yw1xslzl8g1q.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander E. Patrakov" <patrakov@ums.usu.ru> writes:

> Måns Rullgård wrote:
>> Different users of the same system may have perfectly valid reasons to
>> use different locale settings, and thus different filename encodings.
>> Forcing one thing or another is just a useless restriction, and
>> probably not POSIX compliant.
>
> I agree.
>
> Although some people (like glib2 developers) try to say that
> filenames should be in UTF-8, this doesn't work, just because the

IMHO, the glib developers are clueless, and the GNOME crew even more
so.  I remember when the gtk file selection dialog stopped displaying
files with "bad" names, unless I set some wacky undocumented
environment variable first.

> "ls" command assumes that they are in the locale charset. Please fix
> glibc and/or coreutils and all other programs first.

I use utf-8 exclusively for my filenames (the few that are not 7-bit
ascii).  Forcing others who use the system to do the same would cause
them a lot of trouble, as they must transfer files to and from Windows
machines that use anything but utf-8.  The result is that some
filenames are in utf-8, some iso-8859-1, and some euc-kr.  As long as
these stay in each users' home directory, it all works quite well,
though.

-- 
Måns Rullgård
mru@inprovide.com
