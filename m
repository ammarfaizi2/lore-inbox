Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRK0Lth>; Tue, 27 Nov 2001 06:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277258AbRK0Lt1>; Tue, 27 Nov 2001 06:49:27 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:54034 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S277435AbRK0LtW>; Tue, 27 Nov 2001 06:49:22 -0500
Date: Tue, 27 Nov 2001 13:48:59 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: adilger@turbolabs.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011127134859.L4809@niksula.cs.hut.fi>
In-Reply-To: <20011126170631.O730@lynx.no> <Pine.LNX.4.10.10111261614190.9508-100000@master.linux-ide.org> <20011127003843.Z730@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011127003843.Z730@lynx.no>; from adilger@turbolabs.com on Tue, Nov 27, 2001 at 12:38:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 12:38:43AM -0700, you [Andreas Dilger] claimed:
> 
> Oh, I know SMART is implemented, although I haven't actually seen/used a
> tool which takes advantage of it (do you have such a thing?).  It would
> be nice if there were messages appearing in my syslog (just like the
> AIX days) which said "there were 10 temporary read errors at block M on
> drive X yesterday" and "1 permanent write error at block M, block remapped
> on drive X yesterday", so I would know _before_ my drive craps out

There are packaged smartsuite and ide-smart at linux-ide.org. I think smartd
from smartsuite does just that.

At least smartctl does read the values in understandable format.

BTW: does anyone know if it is supposed to understand the temperature
sensors supposedly present in newer IBM drives?


-- v --

v@iki.fi
