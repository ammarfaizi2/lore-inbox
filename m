Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281156AbRKYWPa>; Sun, 25 Nov 2001 17:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281157AbRKYWPZ>; Sun, 25 Nov 2001 17:15:25 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:38927 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S281156AbRKYWOq>;
	Sun, 25 Nov 2001 17:14:46 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15361.27977.474176.551443@cargo.ozlabs.ibm.com>
Date: Mon, 26 Nov 2001 09:14:33 +1100 (EST)
To: Joel Becker <jlbec@evilplan.org>
Cc: Dominik Kubla <kubla@sciobyte.de>, Sven.Riedel@tu-clausthal.de,
        linux-kernel@vger.kernel.org
Subject: Re: Linux and RS/6000 250
In-Reply-To: <20011125213316.J7455@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20011125024652.B26191@moog.heim1.tu-clausthal.de>
	<Pine.NEB.4.33.0111251427280.1488-100000@www2.scram.de>
	<20011125144038.C5506@duron.intern.kubla.de>
	<20011125174742.A5789@moog.heim1.tu-clausthal.de>
	<20011125181051.D5506@duron.intern.kubla.de>
	<20011125213316.J7455@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker writes:

> The 7011-250 uses a PowerPC 601, which may or may not be happy with

The PPC Linux port will run on the 601 cpu just fine.  Linux runs on
the 7200 and 7500 powermacs which are 601-based, as well as various
old 601-based PReP workstations.  (SMP on the 601 is untested and may
not work, though if not it could be made to work without too much
trouble, if anyone cared. :)

MCA is a different story, there is no support for MCA in PPC/Linux.

Paul.
