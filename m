Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTJNGa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 02:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTJNGa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 02:30:58 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:15846 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262015AbTJNGa5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 02:30:57 -0400
Message-ID: <3F8B9820.6010208@namesys.com>
Date: Tue, 14 Oct 2003 10:30:56 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jw@pegasys.ws, linux-kernel@vger.kernel.org, vs@thebsh.namesys.com,
       nikita@namesys.com
Subject: Re: ReiserFS patch for updating ctimes of renamed files
References: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu>	<20031012071447.GJ8724@pegasys.ws>	<3F8A3CE0.4060705@namesys.com>	<20031013032431.1ed40c25.akpm@osdl.org>	<3F8B93F7.2020805@namesys.com> <20031013232527.3cf5701f.akpm@osdl.org>
In-Reply-To: <20031013232527.3cf5701f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>do you think schultz's arguments about why it is wrong are correct?  
>>They seem well thought out to me.
>>    
>>
>
>Well given that you've renamed the file, you do want the backup program to
>pick up the "new" file.  But it'd be a pretty lame backup program which was
>fooled by a missing ctime update.
>
>Yes, John has a point but we're not going to go and change all the other
>filesystems (are we?).
>
>
>
>  
>
why not?  It is correct therefor....

-- 
Hans


