Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTAaUcJ>; Fri, 31 Jan 2003 15:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTAaUcI>; Fri, 31 Jan 2003 15:32:08 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45071 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262258AbTAaUcI>;
	Fri, 31 Jan 2003 15:32:08 -0500
Date: Fri, 31 Jan 2003 21:41:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       Konrad Eisele <eiselekd@web.de>
Subject: Re: Perl in the toolchain
Message-ID: <20030131204132.GA1226@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
	Konrad Eisele <eiselekd@web.de>
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030131194837.GC8298@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 02:48:37PM -0500, Jeff Garzik wrote:
> On Fri, Jan 31, 2003 at 01:41:26PM -0600, Kai Germaschewski wrote:
> > Generally, we've been trying to not make perl a prequisite for the kernel 
> > build, and I'd like to keep it that way. Except for some arch specific 
> 
> That's pretty much out the window when klibc gets merged, so perl will
> indeed be a build requirement for all platforms...

None of the perl scripts looks complicated.
Obivious question is if the same functionality could be achived by a simple
c program.
In the tool chain we use small C utilities in favour of for example
perl scripts in several places.

I would like to see perl kept out of the short-list of required programs
for the main stream kernels.
If the prize to do this is to write one or two small c tools to klibc
then I'm willing to pay that.

	Sam
