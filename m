Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282897AbRK0Tph>; Tue, 27 Nov 2001 14:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282907AbRK0Tp2>; Tue, 27 Nov 2001 14:45:28 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12527
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282897AbRK0TpS>; Tue, 27 Nov 2001 14:45:18 -0500
Date: Tue, 27 Nov 2001 11:45:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Harald Arnesen <gurre@start.no>, linux-kernel@vger.kernel.org
Subject: Re: Release Policy
Message-ID: <20011127114511.D9391@mikef-linux.matchmail.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Harald Arnesen <gurre@start.no>, linux-kernel@vger.kernel.org
In-Reply-To: <873d30r0fv.fsf@basilikum.skogtun.com> <2515.1006856976@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2515.1006856976@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 09:29:36PM +1100, Keith Owens wrote:
> On Tue, 27 Nov 2001 11:08:04 +0100, 
> Harald Arnesen <gurre@start.no> wrote:
> >Anuradha Ratnaweera <anuradha@gnu.org> writes:
> >
> >> How does Marcelo (or Linus or Alan, say) know that the patch
> >> _really_ came from the subsystem aintainer himself?
> >
> >They could reject patches that came without the maintainers GPG or PGP
> >signature.
> 
> Unfortunately the normal GPG/PGP signing changes '-' at start of line
> to '- -', even with clear text signing, and destroys the patch.  You
> have to use --not-dash-escaped in GPG, where the man page says:
> 
> --not-dash-escaped
>   This  option changes the behavior of cleartext signatures so that
>   they can be used for patch files. You should not send such an armored
>   file via email because all spaces and line endings are hashed too.
>   You can not use this option for data which has 5 dashes at the
>   beginning of a line, patch files don't have this. A special armor
>   header line tells GnuPG about this cleartext signature option.
> 

Interesting.

> I don't know if PGP accepts text signed by GPG with --not-dash-escaped
> nor do I know if there really is a problem with mailing such patches.
> But the warning above is nasty enough to rule it out.  The only other
> option for signed patches is uuencode or MIME (with or without
> compression) and Linus does not like that format.
> 

But we're not dealing with Linus with 2.4 anymore.  Maybe Marcello will
accept signed compressed patches.  With a few modifications, most MUAs that
support external processing could be setup to verify the sig, uncompress,
and view in the message area.

MF
