Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVFMTDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVFMTDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVFMTDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:03:31 -0400
Received: from main.gmane.org ([80.91.229.2]:41400 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261220AbVFMS7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:59:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Mon, 13 Jun 2005 20:58:03 +0200
Message-ID: <yw1xekb69j9g.fsf@ford.inprovide.com>
References: <f192987705061303383f77c10c@mail.gmail.com> <1118664352.898.16.camel@tara.firmix.at>
 <f1929877050613065461ad3253@mail.gmail.com>
 <1118673175.898.55.camel@tara.firmix.at>
 <f192987705061310385260ca06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:7jaixtFag5EwrFOajmCQJ388Jzk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Zaytsev <alexey.zaytsev@gmail.com> writes:

> On 13/06/05, Bernd Petrovitsch <bernd@firmix.at> wrote:
>> > The main idea of VFS is that you can access your files in the same way
>> > on any supported file system. But actually you can't simple access
>> > different-encoded non-ascii files on a filesystem that has no NLS,
>> > like ext or reiser.
>> 
>> I don't think that any filesystem knows about the encoding of every
>> filename - after all it is up to the user which encoding he uses for a
>> given file (and no, no one forces me to use the same encoding on the
>> names of all of "mine" files).
>> IOW given a FAT filesystem on an USB stick, which codepage should be
>> used?
>
> Yes, most if not all filesystems don't have any information about file
> names encoding, but the user can often guess it. Hawing files with
> differently-encoded names on the same filesystem is nonsense, which
> could only appear because of the current NLS misfeatures.

Different users of the same system may have perfectly valid reasons to
use different locale settings, and thus different filename encodings.
Forcing one thing or another is just a useless restriction, and
probably not POSIX compliant.

-- 
Måns Rullgård
mru@inprovide.com

