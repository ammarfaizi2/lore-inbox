Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271368AbRIAUtL>; Sat, 1 Sep 2001 16:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271370AbRIAUtB>; Sat, 1 Sep 2001 16:49:01 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:3601 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271368AbRIAUsz>;
	Sat, 1 Sep 2001 16:48:55 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Mike Castle <dalgoda@ix.netcom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: is bzImage container large enough? 
In-Reply-To: Your message of "Sat, 01 Sep 2001 13:42:29 MST."
             <20010901134229.A16630@thune.mrc-home.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 02 Sep 2001 06:49:09 +1000
Message-ID: <25853.999377349@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2001 13:42:29 -0700, 
Mike Castle <dalgoda@ix.netcom.com> wrote:
>On Sun, Sep 02, 2001 at 06:29:41AM +1000, Keith Owens wrote:
>> allmod and make randconfig.  Included in separate mail.
>
>randconfig?
>
>This scares me.   :->

The config is random but valid, it passes the CML1 validation checks.
randconfig is useful for finding errors in the CML1 checks, it also
finds errors in code which assume that a feature is always present.

>Btw, are such things independent of CML being used?  Was wondering if a
>"randconfig" might use CML2 to validate the configuration (as far as CML2
>knows about it).  _Might_ be useful to enhance CML2 to track down
>incompatible configurations.

At the moment, randconfig, allyes, allno, allmod only work for CML1.
Doing randconfig in CML2 is awkward, it may be added later.

