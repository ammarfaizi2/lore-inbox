Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262939AbTC0OBI>; Thu, 27 Mar 2003 09:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262940AbTC0OBI>; Thu, 27 Mar 2003 09:01:08 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:43140 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262939AbTC0OBH>; Thu, 27 Mar 2003 09:01:07 -0500
Date: Thu, 27 Mar 2003 15:12:15 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Bas Vermeulen <bvermeul@blackstar.nl>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre6
Message-ID: <20030327141215.GA25094@wohnheim.fh-wedel.de>
References: <E18yVqr-0004gQ-00@roos.tartu-labor> <Pine.LNX.4.33.0303271144400.27475-100000@devel.blackstar.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0303271144400.27475-100000@devel.blackstar.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 March 2003 11:45:18 +0100, Bas Vermeulen wrote:
> On Thu, 27 Mar 2003, Meelis Roos wrote:
> > 
> > HDLC started generating warnings in some -pre and they are still there:
> > 
> > /oma/compile/linux-2.4/include/linux/modules/hdlc.ver:3: warning: `__ver_register_hdlc_device' redefined
> > /oma/compile/linux-2.4/include/linux/modules/hdlc_generic.ver:3: warning: this is the location of the previous definition
> > /oma/compile/linux-2.4/include/linux/modules/hdlc.ver:5: warning: `__ver_unregister_hdlc_device' redefined
> > /oma/compile/linux-2.4/include/linux/modules/hdlc_generic.ver:5: warning: this is the location of the previous definition
> 
> Try copying .config away, make mrproper, then the normal routine.
> That should fix things for you.

Well, if more that make dep is needed, doesn't this point to a bug in
Config.in and/or Makefile? ;)

I agree, those have less impact, but they should get fixed as well.

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
