Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318751AbSIKNP6>; Wed, 11 Sep 2002 09:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318765AbSIKNP6>; Wed, 11 Sep 2002 09:15:58 -0400
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:41993 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S318751AbSIKNP5>; Wed, 11 Sep 2002 09:15:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: XFS?
Date: Wed, 11 Sep 2002 08:20:36 -0700
User-Agent: KMail/1.4.3
References: <p73wupuq34l.fsf@oldwotan.suse.de> <200209101518.31538.nleroy@cs.wisc.edu> <20020911084327.GF6085@pegasys.ws>
In-Reply-To: <20020911084327.GF6085@pegasys.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209110820.36925.nleroy@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 01:43, jw schultz wrote:

Not that I'm trying to keep this thread alive or anything..

> Yes it does.  I'm guessing the one in 8.0 is an older
> version because i found it performs abysmally.  It seemed
> stable enough but i used it for backups with lots of file
> creation and deletion and my jobs took about 10 times longer
> to run than on ext2 or JFS (also included in the 2.4.18+
> SuSE 8.0)  For other use it is probably fine.  I look
> forward to trying newer versions.

I wasn't making any claims to have _tried_ it or anything.  I simply stated 
that it's _there_ and, I think, supported.  Personally, I've switched to 
Reiserfs (thanks, Hans!), which I'm _really_ happy with.  Yeah, I should 
investigate the other options, but, honestly, there isn't a lot of neccessity 
to.

> And think about this:  In almost all other OSs of substance
> you have one or two basic filesystem types and if you want
> journaling you have to pay extra for it.  And journaling
> filesystems don't have to be fast, there is very little real
> competition.

I'm not sure if you're saying that this is a bad thing or a good thing.  FWIW, 
I think this is a wonderful feature, albeit potentially confusing to a Newbie   
For my O2 running IRIX I get XFS whether I like it or not, for Solaris I get 
UFS no matter how much it sucks (I'm not really saying that it does; I don't 
have much knowledge of it to be honest).  This multitude of choices really 
causes competition between them, and makes them all better in the long run.

Think about this:  Namesys is working on Reiserfs v4.0.  v4.0.  Hell - it's 
only been incorporated into the mainstream kernel for less than a year (at 
least by my recollection), yet it keeps advancing.  I have _no_ idea what UFS 
version Solaris 8 is using (admittedly at least somewhat due to ignorance -- 
I use Solaris because I have a good ol' SPARCprinter which alas is not 
supported by Linux), or whether they've bother to do development on it to 
make it better, faster, etc.  Yet, _we_ get this advancement all the time.  
Isn't it great?!

Ok, time to step off my soapbox and get back to work.

-Nick

