Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265586AbSKFFRh>; Wed, 6 Nov 2002 00:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265588AbSKFFRh>; Wed, 6 Nov 2002 00:17:37 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:52284 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S265586AbSKFFRg>; Wed, 6 Nov 2002 00:17:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mike Diehl <mdiehl@dominion.dyndns.org>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [Evms-devel] EVMS announcement
Date: Tue, 5 Nov 2002 21:54:08 -0500
X-Mailer: KMail [version 1.3.1]
Cc: kcorry@austin.rr.com, evms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0211052332360.6521-100000@steklov.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0211052332360.6521-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021106033350.4B16555A9@dominion.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 11:48 pm, Alexander Viro wrote:
     > On Tue, 5 Nov 2002, Mike Diehl wrote:
     > > Na, I can't ignore the debate.  I can't wait to see how user-land
     > > descovery will be implemented.  There is something intrinsically
     > > "nice" about having an OS automatically discover every aspect of a
     > > machine I'm installing on.  I
     >
     > Kernel _can't_ do that.  In principle.  Simply because part of the
     > kernel that would know how to talk with that PCI card (which just
     > happens to be a SCSI adapter) happens to be a module that lives on a
     > filesystem that lives on a different server and will be accessible
     > only after we configure this NIC.  There is no way in hell to tell
     > what devices sit on the SCSI bus behind that card.  Not without
     > userland participation in the process.

I don't know about you, but my NIC, fs, and Disk drivers are compiled into my 
kernel.  But what you describe is also pretty cool.  I could have a central 
server and the rest of my machines would simply become part of a cluster and 
use the same drives, for the most part.  Neat.

-- 
Mike Diehl
PGP Encrypted E-mail preferred.
Public Key via: http://dominion.dyndns.org/~mdiehl/mdiehl.asc

