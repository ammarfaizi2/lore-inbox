Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290613AbSARHG3>; Fri, 18 Jan 2002 02:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290615AbSARHGU>; Fri, 18 Jan 2002 02:06:20 -0500
Received: from gate.in-addr.de ([212.8.193.158]:34828 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S290613AbSARHGK>;
	Fri, 18 Jan 2002 02:06:10 -0500
Date: Fri, 18 Jan 2002 08:07:14 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Brian Beattie <alchemy@us.ibm.com>
Cc: Mario Mikocevic <mozgy@hinet.hr>, linux-kernel@vger.kernel.org
Subject: Re: FC & MULTIPATH !? (any hope?)
Message-ID: <20020118080714.I937@marowsky-bree.de>
In-Reply-To: <20020114123301.B30997@danielle.hinet.hr> <1011310615.519.3.camel@w-beattie1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1011310615.519.3.camel@w-beattie1>
User-Agent: Mutt/1.3.22.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-01-17T15:36:54,
   Brian Beattie <alchemy@us.ibm.com> said:

> Probable enhancements to this would include, provideing a method to mark
> a path to not attempt this crude form of auto recovery and a way to mark
> a failed path as good.  Finally a device wide flag to disable
> auto-recovery.
> 
> A disadvantage to this approach is that it would potentially, multiply
> the amount or time it takes to ultimately fail the attempt, by the
> number of paths.  This would seem to be acceptable since the alternative
> is to fail the operation when a good route might exist.
> 
> I would appreciate any thoughts, flames, or suggestions.

Combined with the enhancements this makes a lot of sense.

The enhancements are very much required, especially the way to mark a path as
good again manually.

I would also liks easily parseable /proc file to query the status of a
multi-path device, including all paths associated with it.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

