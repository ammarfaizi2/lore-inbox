Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBNOdi>; Wed, 14 Feb 2001 09:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132268AbRBNOd2>; Wed, 14 Feb 2001 09:33:28 -0500
Received: from 64-32-144-137.nyc1.phoenixdsl.net ([64.32.144.137]:268 "HELO
	mail.ovits.net") by vger.kernel.org with SMTP id <S129057AbRBNOdR>;
	Wed, 14 Feb 2001 09:33:17 -0500
Date: Wed, 14 Feb 2001 09:33:36 -0500
From: Mordechai Ovits <movits@ovits.net>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: Rick Hohensee <humbubba@smarty.smart.net>, linux-kernel@vger.kernel.org
Subject: Reason (was: Re: dropcopyright script)
Message-ID: <20010214093336.A8748@ovits.net>
In-Reply-To: <200102140647.BAA24740@smarty.smart.net> <3A8A86ED.F8397F69@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A8A86ED.F8397F69@haque.net>; from mhaque@haque.net on Wed, Feb 14, 2001 at 08:23:57AM -0500
X-Satellite-Tracking: 0x4B305AFF
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In newer file managers, the icon of a C file is a tiny image of the first
few lines of text.  If all files startt with a copyright, it's not much
good.  So running this on a local, personal, tree can be a good thing.

Mordy

On Wed, Feb 14, 2001 at 08:23:57AM -0500, Mohammad A. Haque wrote:
> What prompted this? People are going to want copyright notices in a
> prominent place. Namely at the beginning of the code along with whatever
> instructions and cruft.
> 
> Rick Hohensee wrote:
> > 
> > .......................................................................
> > ## drop copyright notices to the bottoms of C files in current dir and
> > #     subs.
> > # /*
> > #  CopYriGHt Guess Who          2001            All reserves righted.
> > # */
> > 
> > grep -ilr "copyright" . > tempdropcopyrights
> > 
> > for f in `cat tempdropcopyrights`
> > do
> > ed $f <<HEREDOC
> > /[Cc][oO][pP][yY][rR][iI]/
> > ?\/\*?
> > .,/\*\//m$
> > wq
> > HEREDOC
> > done
> > ........................................................................
> > 
> 
> -- 
> 
> =====================================================================
> Mohammad A. Haque                              http://www.haque.net/ 
>                                                mhaque@haque.net
> 
>   "Alcohol and calculus don't mix.             Project Lead
>    Don't drink and derive." --Unknown          http://wm.themes.org/
>                                                batmanppc@themes.org
> =====================================================================
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
