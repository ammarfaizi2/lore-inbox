Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318097AbSIJTvN>; Tue, 10 Sep 2002 15:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318101AbSIJTvN>; Tue, 10 Sep 2002 15:51:13 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:48399 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318097AbSIJTvM>; Tue, 10 Sep 2002 15:51:12 -0400
Message-ID: <3D7E4E4A.4000404@namesys.com>
Date: Tue, 10 Sep 2002 23:55:54 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, green@namesys.com
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k
 at a time)
References: <3D7DF05E.7030903@namesys.com> <20020910160659.A15158@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Tue, Sep 10, 2002 at 05:15:10PM +0400, Hans Reiser wrote:
>
> > It passes all of our testing, but it is the kind of code that is more 
> > likely than most to have elusive lurking bugs.  It cannot be tested in 
> > 2.5 first because 2.5 is too broken at this particular moment.
>
>What in particular holds you back from testing this in 2.5 ?
>
Oleg answered this.

>This seems quite dubious for inclusion first in what it supposed
>to be the stable series.
>
>        Dave
>
>  
>
It is a performance tweak, not a new feature.  2.5 is for things like 
reiser4.  Also, remember that we do perform internal testing, and we 
also tested this on our mailing list, which makes our tweaks much more 
stable than most of the tweaks that go into 2.5 first. It is strange, 
but Namesys seems to have much more of a release management 
infrastructure than most code submitters (I think that means merely that 
we have one;-), since there are two persons that test every patch, and 
that makes us oddly unusual).   However, waiting for 2.4.21pre1 is also 
quite reasonable since the number of lines of new code is significant, 
and reiserfs is used on mission critical servers.   A lot depends on 
just how soon 2.4.20 is planned to come out, and only Marcelo knows that.

Hans

