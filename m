Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWBYXXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWBYXXp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 18:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWBYXXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 18:23:45 -0500
Received: from smtp.e7even.com ([83.151.192.19]:9877 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S1750725AbWBYXXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 18:23:44 -0500
Message-ID: <4400E6F8.1080907@st-andrews.ac.uk>
Date: Sat, 25 Feb 2006 23:23:36 +0000
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>
Subject: Re: creating live virtual files by concatenation
References: <1271316508.20060225153749@dns.toxicfilms.tv> <9a8748490602250735l6161a96dte2805b772a89a436@mail.gmail.com> <612760535.20060225181521@dns.toxicfilms.tv> <Pine.LNX.4.63.0602251339320.13659@cuia.boston.redhat.com> <9a8748490602251052p3e56334ei755c9ce2100e03c@mail.gmail.com> <1391154345.20060225203352@dns.toxicfilms.tv> <4400DA93.9080901@st-andrews.ac.uk> <Pine.LNX.4.63.0602251736340.13659@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0602251736340.13659@cuia.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Sat, 25 Feb 2006, Peter Foldiak wrote:
>
>>sub-file" corresponding to a key-range. Writing a chapter should change the
>>book that the chapter is part of. That is what would make it really valuable.
>>Of course it would have all sorts of implications (e.g. for metadata for each
>>part) that need to be thought about, but it could be done properly, I think.
>>    
>>
>
>What happens if you read the first 10kB of a file,
>and one of the "chapters" behind your read cursor
>grows?
>
>Do you read part of the same data again when you
>continue reading?
>
>Does the read cursor automatically advance?
>  
>
You should probably continue where you left off .

>Your idea changes the way userspace expects files
>to behave...
>  
>
Yes, I know.
