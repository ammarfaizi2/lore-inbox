Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272124AbRIEMXT>; Wed, 5 Sep 2001 08:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272126AbRIEMXK>; Wed, 5 Sep 2001 08:23:10 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:5896 "HELO dvmwest.gt.owl.de")
	by vger.kernel.org with SMTP id <S272124AbRIEMW7>;
	Wed, 5 Sep 2001 08:22:59 -0400
Date: Wed, 5 Sep 2001 14:23:18 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac6
Message-ID: <20010905142318.B20609@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <NOEJJDACGOHCKNCOGFOMAEAPDLAA.davids@webmaster.com> <E15ebSj-0005ig-00@the-village.bc.nu> <3B9617BA.F771914E@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B9617BA.F771914E@redhat.com>; from arjanv@redhat.com on Wed, Sep 05, 2001 at 01:16:58PM +0100
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-09-05 13:16:58 +0100, Arjan van de Ven <arjanv@redhat.com>
wrote in message <3B9617BA.F771914E@redhat.com>:
> Alan Cox wrote:
> > > based upon whether you have the source or not. What should logically taint
> > > the kernel are modules that weren't compiled for that exact kernel version
> > > or are otherwise mismatched.
> > Setting a flag for the insmod -f required case as well is an extremely good
> > idea. This is entirely about making information available nothing else and
> > your suggestion there is a good one.
> 
> How about making the "tainted" field a bitmask ?
> eg bit 0 --> non GPL/BSD module
>    bit 1 --> insmod -f

Basically, I don't like that idea. 'insmod -f' should only be
required if the module in question is some kind of a commercial (TM)
module. Setting a "GPL/BSD" flag might be somewhat interesting
(but enlarges needed on-disk-space), but I don't like to help
those commercials to ease the use of their broken, binary-only
modules.

MfG, JBG

-- 
Jan-Benedict Glaw . jbglaw@lug-owl.de . +49-172-7608481
