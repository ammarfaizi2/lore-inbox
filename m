Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266655AbSKGWza>; Thu, 7 Nov 2002 17:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266656AbSKGWza>; Thu, 7 Nov 2002 17:55:30 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:56068 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S266655AbSKGWz3>; Thu, 7 Nov 2002 17:55:29 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Why are exe, cwd, and root priviledged bits of information?
Date: 7 Nov 2002 22:44:09 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <aqeqbp$hgi$1@abraham.cs.berkeley.edu>
References: <Pine.LNX.4.33L2.0211071052540.8252-100000@rtlab.med.cornell.edu> <20021107160521.GA18270@nevyn.them.org> <20021107221615.GA2249@pegasys.ws>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1036709049 17938 128.32.153.211 (7 Nov 2002 22:44:09 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 7 Nov 2002 22:44:09 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz  wrote:
>On Thu, Nov 07, 2002 at 11:05:21AM -0500, Daniel Jacobowitz wrote:
>> For instance:
>>   You can protect a directory by giving its parent directory no read
>> permissions.  The name of the directory is now secret.  You don't want
>> to reveal it in cwd.
>
>Daniel is correct in that the issue came up recently.  He
>gives _his_ answer above.  If you believe in security
>through obscurity you will agree with him.

Huh?  This has nothing to do with security through obscurity.
This has to do with the Unix permissions model.  /proc/pid probably
shouldn't leak information that would otherwise be kept confidential in the
standard Unix permissions model (principle of least surprise, etc.).

>I will agree that there should be no real reason to need
>access to this information.

They why is it allowed?  Allowing something that noone needs and
that breaks most people's intuitions of how security will work seems
like a pretty questionable idea.
