Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTCFPGt>; Thu, 6 Mar 2003 10:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTCFPGt>; Thu, 6 Mar 2003 10:06:49 -0500
Received: from CPE-144-132-203-93.nsw.bigpond.net.au ([144.132.203.93]:14470
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S265063AbTCFPGs>; Thu, 6 Mar 2003 10:06:48 -0500
Date: Thu, 6 Mar 2003 23:12:40 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: [PATCH]  fix undefined reference for sis drm.
Message-ID: <20030306151240.GA10810@anakin.wychk.org>
References: <20030306101017.GA6479@anakin.wychk.org> <1046963902.17715.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
In-Reply-To: <1046963902.17715.37.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Direct render occurs before the frame buffer so it doesn't work
> In addition you can have both modular so you'd want to make it
> 
> dep_tristate '   SiS' CONFIG_DRM_SIS $CONFIG_AGP $CONFIG_FB_SIS
> 
> even if the order worked out.


Hm, yes indeed.  Please apply the correct fix to your tree.

Sorry about the botched fix.


	-- G.

-- 
char p[] = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";


