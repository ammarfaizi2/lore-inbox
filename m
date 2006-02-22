Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWBVJCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWBVJCA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 04:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWBVJCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 04:02:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22181 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932514AbWBVJCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 04:02:00 -0500
Date: Wed, 22 Feb 2006 10:01:45 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: mauelshagen@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: *** Announcement: dmraid 1.0.0.rc10 ***
Message-ID: <20060222090145.GN23661@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <20060217210635.GA13074@redhat.com> <m28xs4k80d.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m28xs4k80d.fsf@vador.mandriva.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 05:10:26PM +0100, Thierry Vignaud wrote:
> Heinz Mauelshagen <mauelshagen@redhat.com> writes:
> 
> >                *** Announcement: dmraid 1.0.0.rc10 ***
> > 
> > dmraid 1.0.0.rc10 is available at
> > http://people.redhat.com/heinzm/sw/dmraid/ in source tarball,
> > source rpm and i386 rpm (with shared and static binary).
> > 
> > This release adds support for Adaptec HostRAID and JMicron JMB36X
> > (see CHANGELOG below for more information).
> 
> you're missusing AC_ARG_ENABLE: it cannot assume whereas you want to
> default to --enable-XXX or --disable-XXX.
> 
> eg passing --disable-selinux to dmraid's configures make it actually
> enable selinux support :-(

Well, I better tested --disable-libselinux rather than just leaving
the respective option out or configure --enable-libselinux, which most people
will do anyway ;-)

> 
> the format is "AC_ARG_ENABLE(name, help, [ use given value ], [ default action ])"
> 
> the following patch fixes it:

Applied.

> 
> you might want to alter default values then since i guess you
> misunderstood what the arguments should have been.

Hrm, configure option got added last minute.

Thanks,
Heinz

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
Cluster and Storage Development                   56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
