Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSGBLbE>; Tue, 2 Jul 2002 07:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSGBLbD>; Tue, 2 Jul 2002 07:31:03 -0400
Received: from [62.70.58.70] ([62.70.58.70]:34951 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316728AbSGBLbC> convert rfc822-to-8bit;
	Tue, 2 Jul 2002 07:31:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Helge Hafting <helgehaf@aitel.hist.no>,
       Zwane Mwaikambo <zwane@mwaikambo.name>
Subject: Re: lilo/raid?
Date: Tue, 2 Jul 2002 13:33:36 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207011758180.3104-100000@netfinity.realnet.co.sz> <3D216157.FC60B17E@aitel.hist.no>
In-Reply-To: <3D216157.FC60B17E@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207021333.36435.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 July 2002 10:16, Helge Hafting wrote:
> Zwane Mwaikambo wrote:
> > On Mon, 1 Jul 2002, Roy Sigurd Karlsbakk wrote:
> > > LABEL=/                 /                       ext3    defaults       
> > > 1 1 /dev/md2                /tmp                    ext3    defaults   
> > >     1 2 /dev/md3                /var                    jfs    
> > > defaults        1 2 /dev/md4                /data                   jfs
> > >     defaults        1 2 /dev/md1                swap                   
> > > swap    defaults        0 0
> >
> > One small thing, you do know that you can interleave swap?
>
> There are sometimes reasons not to do that.
> Heavy swapping may be caused by attempts to cache
> massive io on some fs.  
<snip/>

I've seen it. 1GB of swap for caching heavy downloads (se earlier thread 'VM 
fsckup' or somehting)

What is the reason of using swap for cache buffers?????

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

