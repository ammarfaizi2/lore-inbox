Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbTJOKj0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTJOKj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:39:26 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:13723 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262626AbTJOKjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:39:25 -0400
Message-ID: <3F8D23DB.3070105@namesys.com>
Date: Wed, 15 Oct 2003 14:39:23 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norman Diamond <ndiamond@wta.att.ne.jp>
CC: Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com
Subject: Re: Why are bad disk sectors numbered strangely, and what happens
 to them?
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <00ed01c39306$b0277a90$3eee4ca5@DIAMONDLX60>
In-Reply-To: <00ed01c39306$b0277a90$3eee4ca5@DIAMONDLX60>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond wrote:

>Hans Reiser wrote:
>
>  
>
>>I think the problem is that many users don't know how to trigger the bad
>>sector remapping for the case where the drive can still remap, using
>>writes to the bad blocks, and probably our faq needs updating.
>>    
>>
>
>This is indeed one of the problems[*].  The other problem is that it seems
>to be absurdly difficult to find which file contains the bad sector.  Even
>though a file could have multiple hard links, it would be enough to get one
>pathname for the file, in order to know which file needs to be reconstructed
>from a source of good data.
>
>[* Of course I also wish that the original failing write had been detected
>by the drive, but this failure isn't software's fault.  I hope.]
>
>
>
>  
>
badblocks program fixes that

-- 
Hans


