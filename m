Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRB0TVg>; Tue, 27 Feb 2001 14:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129772AbRB0TVQ>; Tue, 27 Feb 2001 14:21:16 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:37899 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129771AbRB0TVH>;
	Tue, 27 Feb 2001 14:21:07 -0500
Date: Tue, 27 Feb 2001 20:20:59 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ivo Timmermans <irt@cistron.nl>
Cc: "Heusden, Folkert van" <f.v.heusden@ftr.nl>, linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010227202059.C11060@pcep-jamie.cern.ch>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F2D@ftrs1.intranet.ftr.nl> <20010227143823.A25058@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010227143823.A25058@cistron.nl>; from irt@cistron.nl on Tue, Feb 27, 2001 at 02:38:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivo Timmermans wrote:
> > _should_ it work with the \r in it?
> 
> IMHO, yes.  This set of files were created on Windows, then zipped and
> uploaded to a Linux server, unpacked.  This does not change the \r.

Use `fromdos' to convert the files.  Or this little Perl gem, which
takes a list of files or standard input as argument:

#!/usr/bin/perl -pi
s/\r\n$/\n/

-- Jamie
