Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVFMTmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVFMTmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVFMTmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:42:35 -0400
Received: from main.gmane.org ([80.91.229.2]:22482 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261238AbVFMTkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:40:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Mon, 13 Jun 2005 21:38:30 +0200
Message-ID: <yw1x1x769he1.fsf@ford.inprovide.com>
References: <f192987705061303383f77c10c@mail.gmail.com> <1118669746.13260.20.camel@localhost.localdomain>
 <f192987705061310202e2d9309@mail.gmail.com>
 <1118690448.13770.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:lLk/NgVfGdxNBXSBnLc1br7C3I4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Llu, 2005-06-13 at 18:20, Alexey Zaytsev wrote:
>> Yes, that's how it works, but if I want ext or reiser or whatever to
>> have NLS, I'll have to make them support it (btw, if I do so, wont it
>> be rejected?). I want to move the NLS one level upper so the
>> filesystem imlementations won't have to worry about it any more. I
>> don't have much kernel experience, and none in the fs area, so I can't
>> explain it any better, but hope you get the idea.
>
> An ext3fs is always utf-8. People might have chosen to put other
> encodings on it but thats "not our fault" ;)

I was of the impression that most filesystems (ext3 included) treated
file names as a sequence of bytes, and didn't care about encoding.
Please correct me if I am wrong.

-- 
Måns Rullgård
mru@inprovide.com

