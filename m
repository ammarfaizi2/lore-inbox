Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264658AbSKDMVp>; Mon, 4 Nov 2002 07:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264659AbSKDMVp>; Mon, 4 Nov 2002 07:21:45 -0500
Received: from gate.in-addr.de ([212.8.193.158]:63762 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S264658AbSKDMVo>;
	Mon, 4 Nov 2002 07:21:44 -0500
Date: Mon, 4 Nov 2002 13:27:59 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net,
       lkcd-general@lists.sourceforge.net,
       lkcd-general-admin@lists.sourceforge.net
Subject: Re: [lkcd-general] Re: What's left over.
Message-ID: <20021104122759.GG19368@marowsky-bree.de>
References: <OFE5D1360D.AD5C65BE-ON80256C67.004027FF@portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFE5D1360D.AD5C65BE-ON80256C67.004027FF@portsmouth.uk.ibm.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-11-04T11:59:23,
   Richard J Moore <richardj_moore@uk.ibm.com> said:

> So, for those of use who passionately care whether Linux has a system
> dumping mechanism, we need to regroup, we need to decide the correct
> strategy for gaining LKCD's inclusion into the kernel.  Many of the
> arguments relate to timeliness and ultimately have a commercial benefit. I
> suggest we actively campaign among the various distros who are interested
> in selling Linus businesses and provide support. We also need to
> concentrate on consolidating the various requirements of a system crash
> dump - it's going to be much easier for everyone if there is a consensus on
> system dumping technology.

I think you are somewhat missing the point.

Both RH and UnitedLinux seem to care enough for system dump facilities that
they ship patched kernels (netdump / LKCD, respectively). Anyone who cares can
simply apply the patch themselves, if they want to compile from vanilla
sources. Just buy RH AS or any enterprise product powered by United Linux, and
off you go. I assume that your "enterprise customers" will want to do that
anyway because they need all those very useful certifications...

And since l-k (rightly!) mostly refuses to deal with crash/oops reports from
vendor patched kernels anyway, the distributors have to deal with the
diagnosis themselves already and do so as part of the support contracts.
Anyone who runs their own patched kernels probably also is able to do so.

While I can see the issue that having the patch included in the mainstream
kernel offers the usual advantages, it is by no means the absolute requirement
you make it out to be.

It appears that the facilities are all there now; so 2.6 should be a the
perfect time to test the various approaches in the field. (And face it, field
experience is rather limitted still, but I am very sure it will grow soon
because it is such a useful feature)

Then it can be included. This is how Linux has always worked. reiserfs has
gone through this, as has ext3, XFS, quite a few of the VM patches etc. So no
worries, nobody is being exceptionally harsh in any fashion.

But arguing about "I have so many fortune 100 companies just lined up ready to
say that they support this campaign!" is marketing speak. Go away with that
from Linux kernel, will you.

Come back when it is "I have so many fortune 100 companies actively using this
feature and have solved many problems with it!".


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
