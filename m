Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbUJ3TNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbUJ3TNS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUJ3TNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:13:12 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:41612 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261256AbUJ3TLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:11:44 -0400
Message-ID: <4183E775.3090701@namesys.com>
Date: Sat, 30 Oct 2004 12:11:49 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Timo Sirainen <tss@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org> <20041028093426.GB15050@merlin.emma.line.org> <20041028114413.GL1343@schnapps.adilger.int> <4182B2FF.9040902@namesys.com> <Pine.LNX.4.53.0410292326300.8389@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0410292326300.8389@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>Matthias is right.  readdir is badly architected, and no one has fixed
>>it for ~30 years.
>>    
>>
>
>As long as M$ windows has the same problem, it's justified that we have that
>problem for 30 years now.
>
>  
>
>>It should be possible to perform an atomic readdir if that is what you
>>want to do and if you have space in your process to stuff the result.
>>    
>>
>
>How much would it cost to always append the new name into the directory rather
>than modifying it in place?
>
Forgive me, what does the sentence above mean?  Paste it out of order?

Better to fix the API.

> OTOH, especially Reiserfs does not use linear file
>lists, so it would get tricky.
>
>
>
>  
>
We use sorted directories.
