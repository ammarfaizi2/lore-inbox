Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263709AbREYLW3>; Fri, 25 May 2001 07:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263712AbREYLWT>; Fri, 25 May 2001 07:22:19 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:1032 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S263710AbREYLWP>; Fri, 25 May 2001 07:22:15 -0400
Date: Fri, 25 May 2001 13:15:02 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
Subject: Re: ac15 and 2.4.5-pre6, pwc format conversion
Message-ID: <20010525131502.I12364@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010525085024.A17867@alpha.logic.tuwien.ac.at> <XFMail.010525104812.nemosoft@smcc.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.010525104812.nemosoft@smcc.demon.nl>; from nemosoft@smcc.demon.nl on Fri, May 25, 2001 at 10:48:12AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 10:48:12AM +0200, Nemosoft Unv. wrote:
> On 25-May-01 Norbert Preining wrote:
> > According to ac ChangeLog:
> > o       Rip format conversion out of the pwc driver     (me)
> >         | It belongs in user space..
> > 
> > This change is included in 2.4.5-pre6, but
> >       drivers/usb/pwc-uncompress.c
> > pwc-uncompress.c:185: warning: implicit declaration of function
> > `vcvt_420i_420p'
> 
> That´s what you get for ripping out the guts of a driver. Have a nice day.

The format conversion shouldn't be there in the first place. Format
conversion is policy, so it doesn't belong in kernel. Note for example
that none of the sound drivers does sample rate conversion although
some sound chips are locked at 48kHz only.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
