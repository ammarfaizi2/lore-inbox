Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310766AbSCHJig>; Fri, 8 Mar 2002 04:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310768AbSCHJi0>; Fri, 8 Mar 2002 04:38:26 -0500
Received: from 213-97-45-174.uc.nombres.ttd.es ([213.97.45.174]:52753 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id <S310766AbSCHJiQ>;
	Fri, 8 Mar 2002 04:38:16 -0500
Date: Fri, 8 Mar 2002 10:38:07 +0100 (CET)
From: Pau Aliagas <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>, Erik Andersen <andersen@codepoet.org>
cc: Rik van Riel <riel@conectiva.com.br>,
        "Jonathan A. George" <JGeorge@greshamstorage.com>
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <20020308003827.GA8348@codepoet.org>
Message-ID: <Pine.LNX.4.44.0203081032310.2580-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Erik Andersen wrote:

> On Thu Mar 07, 2002 at 08:59:47PM -0300, Rik van Riel wrote:
> > 5) ability to exchange changesets by email
> 
> 6) Ability to do sane archival and renaming of directories.
>     CVS doesn't even know what a directory is.

Doable with arch. You can rename dirs and remove them, also files, and it 
will detect it generating a much smaller patchset. It all depends on the 
tagging you choose for files be it implicit -tags inside the file-, 
explicit -ci, co- or by name.

> 7) Support for archiving symlinks, device special files, fifos,
>     etc.

You chose what is source code with regular exps. Symlinks sure work, the 
rest not sure, but think so.

Pau

