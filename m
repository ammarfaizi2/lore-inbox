Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVFNH7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVFNH7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVFNH7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:59:20 -0400
Received: from relay4.usu.ru ([194.226.235.39]:8392 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S261323AbVFNH7H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:59:07 -0400
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
To: "=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=" <mru@inprovide.com>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Tue, 14 Jun 2005 14:04:06 +0600
User-Agent: KMail/1.7.2
References: <f192987705061303383f77c10c@mail.gmail.com> <f192987705061310385260ca06@mail.gmail.com> <yw1xekb69j9g.fsf@ford.inprovide.com>
In-Reply-To: <yw1xekb69j9g.fsf@ford.inprovide.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506141404.06888.patrakov@ums.usu.ru>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.31.0.5; VDF: 6.31.0.48; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Different users of the same system may have perfectly valid reasons to
> use different locale settings, and thus different filename encodings.
> Forcing one thing or another is just a useless restriction, and
> probably not POSIX compliant.

I agree.

Although some people (like glib2 developers) try to say that filenames should 
be in UTF-8, this doesn't work, just because the "ls" command assumes that 
they are in the locale charset. Please fix glibc and/or coreutils and all 
other programs first.

-- 
Alexander E. Patrakov
