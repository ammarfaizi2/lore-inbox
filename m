Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262183AbSJASdc>; Tue, 1 Oct 2002 14:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262188AbSJASdc>; Tue, 1 Oct 2002 14:33:32 -0400
Received: from angband.namesys.com ([212.16.7.85]:64162 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262183AbSJASdb>; Tue, 1 Oct 2002 14:33:31 -0400
Date: Tue, 1 Oct 2002 22:38:53 +0400
From: Oleg Drokin <green@namesys.com>
To: Jeff Dike <jdike@karaya.com>
Cc: James Stevenson <james@stev.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] uml-patch-2.5.39
Message-ID: <20021001223853.B10665@namesys.com>
References: <20021001114454.A27039@namesys.com> <200210011819.NAA02853@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200210011819.NAA02853@ccure.karaya.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Oct 01, 2002 at 01:19:36PM -0500, Jeff Dike wrote:
> > @@ -863,6 +863,7 @@
> >  			return(-EFAULT);
> >  		return(0);
> >  	}
> > +	return -ENOTTY;
> >  }
> I did a check of some of the other block drivers, and they mostly seem to
> do -EINVAL rather than -ENOTTY.  There was an oddball -ENOSYS, but I guess
> I'll stick with -EINVAL.

Well, it can be both ways (EINVAL and ENOTTY).
Probably EINVAL is more close in this case, though.
I'll send the stacktraces tomorrow, when I'll get to work.

Bye,
    Oleg
