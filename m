Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129687AbRBNNYZ>; Wed, 14 Feb 2001 08:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbRBNNYQ>; Wed, 14 Feb 2001 08:24:16 -0500
Received: from viper.haque.net ([64.0.249.226]:16777 "EHLO viper.haque.net")
	by vger.kernel.org with ESMTP id <S129055AbRBNNX6>;
	Wed, 14 Feb 2001 08:23:58 -0500
Message-ID: <3A8A86ED.F8397F69@haque.net>
Date: Wed, 14 Feb 2001 08:23:57 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Hohensee <humbubba@smarty.smart.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: dropcopyright script
In-Reply-To: <200102140647.BAA24740@smarty.smart.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What prompted this? People are going to want copyright notices in a
prominent place. Namely at the beginning of the code along with whatever
instructions and cruft.

Rick Hohensee wrote:
> 
> .......................................................................
> ## drop copyright notices to the bottoms of C files in current dir and
> #     subs.
> # /*
> #  CopYriGHt Guess Who          2001            All reserves righted.
> # */
> 
> grep -ilr "copyright" . > tempdropcopyrights
> 
> for f in `cat tempdropcopyrights`
> do
> ed $f <<HEREDOC
> /[Cc][oO][pP][yY][rR][iI]/
> ?\/\*?
> .,/\*\//m$
> wq
> HEREDOC
> done
> ........................................................................
> 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
