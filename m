Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287809AbSAFLJr>; Sun, 6 Jan 2002 06:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287816AbSAFLJh>; Sun, 6 Jan 2002 06:09:37 -0500
Received: from [217.9.226.246] ([217.9.226.246]:7809 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S287809AbSAFLJb>; Sun, 6 Jan 2002 06:09:31 -0500
To: paulus@samba.org
Cc: dewar@gnat.com, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020106042617.E64B0F28BD@nile.gnat.com>
	<15415.57685.984456.586108@argo.ozlabs.ibm.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <15415.57685.984456.586108@argo.ozlabs.ibm.com>
Date: 06 Jan 2002 13:09:32 +0200
Message-ID: <87wuyvhh1v.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paul" == Paul Mackerras <paulus@samba.org> writes:

Paul> I find it hardly helpful to be told that doing that is invalid without
Paul> anyone offering me a valid way to achieve the effect I want - and
Paul> no-one has, other than to say that as long as I dereference the

Number of people suggested using assembly for this, why you keep
ignoring it and insist instead on changing the compiler, changing the
C standard, switching to another compiler and similar unproductive
ideas put forward solely for the sake of argument ?

Paul> pointer some time later, in a different procedure, it should be fine.
Paul> Which is fine from a pragmatic point of view but it doesn't alter the
Paul> validity or invalidity of the operation.

>From a _pragmatic_ point of view you can just keep the code as is,
fixing the _extremely_ rare cases where violations of the standard
interfere with compiler optimizations.  It is too much to ask to
penalize _all_ the software by preventing the compiler from doing
optimizations for the convenience of the maintainers of the PPC port
of Linux. As for listening to the users of the compiler (you mentioned
this in another mail), GCC maintainers (an C comitee, for that matter)
do exactly this. You just have to realize that _we_ are minority,
important, by nevertheless minority.

Regards,
-velco

