Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSKTXmN>; Wed, 20 Nov 2002 18:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264637AbSKTXmC>; Wed, 20 Nov 2002 18:42:02 -0500
Received: from gate.in-addr.de ([212.8.193.158]:1034 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S263837AbSKTXl6>;
	Wed, 20 Nov 2002 18:41:58 -0500
Date: Thu, 21 Nov 2002 00:30:20 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Steven Dake <sdake@mvista.com>, Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021120233020.GE29881@marowsky-bree.de>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <3DDBC0D9.5030904@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DDBC0D9.5030904@mvista.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-11-20T10:05:29,
   Steven Dake <sdake@mvista.com> said:

> This could be done without this field, but then the RAID arrays could be 
> started unintentionally by the wrong host.  Imagine a host starting the 
> wrong RAID array while it has been already started by some other party 
> (forcing a rebuild) ugh!

This is already easy and does not require addition of a field to the md
superblock.

Just only explicitly start disks with the proper uuid in the md superblock.
Don't simply start them all.

(I'll reply to Neil's mail momentarily)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
