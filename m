Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRDNWkx>; Sat, 14 Apr 2001 18:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbRDNWkn>; Sat, 14 Apr 2001 18:40:43 -0400
Received: from www.inreko.ee ([195.222.18.2]:23938 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S131157AbRDNWki>;
	Sat, 14 Apr 2001 18:40:38 -0400
Date: Sun, 15 Apr 2001 00:56:24 +0200
From: Marko Kreen <marko@l-t.ee>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Thorsten Glaser Geuer <eccesys@topmail.de>, linux-kernel@vger.kernel.org
Subject: Re: Still cannot compile, 2.4.3-ac6
Message-ID: <20010415005624.A11455@l-t.ee>
In-Reply-To: <20010414210834.4D195A5A843@www.topmail.de> <20010415010335.X805@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010415010335.X805@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Sun, Apr 15, 2001 at 01:03:35AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2001 at 01:03:35AM +0300, Matti Aarnio wrote:
> On Sat, Apr 14, 2001 at 09:09:00PM +0000, Thorsten Glaser Geuer wrote:
> > Dear Sirs,
> > I still cannot compile with gcc-3.0 from 08.04.
> 
> 	Yes ?  Who said gcc-3.0 is suitable compiler ?
> 
> 	No doubt it some day will be the default compiler, but not yet.

Sorry.  Who said it should not be tested?  How else it could get
'default compiler'?  If the gcc-3.0 would start giving errors
on some old code then it could be gcc bug.  But this rwsem code
is couple of days old.  It is good to let it through stricter
error checking, I guess.  This rwsem is very in-flux code.  eg.
2.4.4-pre2 did not compile.  ac[56] with um-arch do not compile.

If nothing else convinces, then AFAIK both Linus and Alan
expressed interest in seeing reports of using newer gcc's.
Remember, gcc-3.0 is in freeze since Feb 12.  (Ofcourse they
also suggested against using random CVS snapshot as default
compiler in distrubution).

-- 
marko

