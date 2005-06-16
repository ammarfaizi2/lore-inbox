Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVFPKjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVFPKjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 06:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVFPKjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 06:39:20 -0400
Received: from main.gmane.org ([80.91.229.2]:25569 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261551AbVFPKjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 06:39:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Thu, 16 Jun 2005 12:38:43 +0200
Message-ID: <yw1x4qby1t8s.fsf@ford.inprovide.com>
References: <f192987705061303383f77c10c@mail.gmail.com> <20050615212825.GS23621@csclub.uwaterloo.ca>
 <42B0BAF5.106@poczta.fm> <200506152144.56540.pmcfarland@downeast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:cSWmqtGBujP4QK6TWsBHck87Ql0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McFarland <pmcfarland@downeast.net> writes:

> On Wednesday 15 June 2005 07:34 pm, Lukasz Stelmach wrote:
>> That's why UTF-8 is suggested. UTF-8 has been developed to "fool" the
>> software that need not to be aware of unicodeness of the text it manages
>> to handle it without any hickups *and* to store in the text information
>> about multibyte characters.What characters exactly you do mean? NULL?
>> There is no NULL byte in any UTF-8 string except the one which
>> terminates it.
>
> Bingo. Only the operating system itself and software displaying
> filenames needs to understand Unicode; the file system
> implementation itself just knows its a string of bytes and nothing
> else.

Not even the OS needs to know what the bytes mean.  Only applications
displaying the names have reason to interpret the bytes they are
composed of in any specific manner.

-- 
Måns Rullgård
mru@inprovide.com

