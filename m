Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVFAMOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVFAMOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVFAMOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:14:32 -0400
Received: from odin2.bull.net ([192.90.70.84]:50316 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261357AbVFAMNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:13:52 -0400
Subject: Re: RT : 2.6.12rc5 + realtime-preempt-2.6.12-rc5-V0.7.47-15
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050601082351.GA30690@elte.hu>
References: <1117551231.19367.48.camel@ibiza.btsn.frna.bull.fr>
	 <1117568825.23283.5.camel@mindpipe>
	 <1117613246.5580.70.camel@ibiza.btsn.frna.bull.fr>
	 <20050601082351.GA30690@elte.hu>
Content-Type: multipart/mixed; boundary="=-CXU8AE1bNA946FwboHoc"
Organization: BTS
Message-Id: <1117627375.5580.283.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Wed, 01 Jun 2005 14:02:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CXU8AE1bNA946FwboHoc
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le mer 01/06/2005 =E0 10:23, Ingo Molnar a =E9crit :
> * Serge Noiraud <serge.noiraud@bull.net> wrote:
>=20
> > Le mar 31/05/2005 =E0 21:47, Lee Revell a =E9crit :
> > > On Tue, 2005-05-31 at 16:53 +0200, Serge Noiraud wrote:
> > > > I have a test program which made a loop in RT to mesure the system
> > > > perturbation.
> > > > It works finely in a tty environment.
> > > > When I run it in an X environment ( xterm ), I get something like i=
f I
> > > > click the Enter key in the active window.
> > > > If I open a new xterm, this is the new active window which receive =
these
> > > > events.
> > > > These events stop when the program stop.
> > > >=20
> > > > I tried with X in RT and no RT : I have the problem.
> > >=20
> > > Try adding:
> > >=20
> > > Option "NoAccel"
> > Same problem.
>=20
> could you enable latency timing and tracing in the .config:
>=20
>  CONFIG_CRITICAL_PREEMPT_TIMING=3Dy
>  CONFIG_CRITICAL_IRQSOFF_TIMING=3Dy
>  CONFIG_LATENCY_TIMING=3Dy
>  CONFIG_LATENCY_TRACE=3Dy
Already in the config. I have the following too :
CONFIG_CRITICAL_TIMING=3Dy
>=20
> and start a new search for a maximum latency via:
>=20
>  echo 0 > /proc/sys/kernel/preempt_max_latency
>=20
> and then do the X test - what is the largest latency reported in=20
> 'dmesg'? Also, please send me a (bzip2 -9 compressed, if too large)=20
> /proc/latency_trace trace output of the largest incident.
The max latency reported are normal.

I have the problem with another program which mesure latencies about
semaphore only in X environment too.
       =20
I tried to ssh this machine from another X environment and the problem
does not exist. It's only on the console.
>=20
> 	Ingo

--=-CXU8AE1bNA946FwboHoc
Content-Disposition: attachment; filename=dmesg.txt.bz2
Content-Type: application/x-bzip; name=dmesg.txt.bz2
Content-Transfer-Encoding: base64

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

--=-CXU8AE1bNA946FwboHoc
Content-Disposition: attachment; filename=latency_trace.txt.bz2
Content-Type: application/x-bzip; name=latency_trace.txt.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWYzkB6MABp//gHT+EABIb//3bEpLBL9v/2RQBDe7Z6MD1nt3I3pDISSe1MptomIR
+qNDQ0NAD1AaB6gCRJGEJtVPI1AGQyPRAAAAAET0JEGgADQ0aAAAAAAEeqRPUNGTTTIAaGgAAAAA
AiSU1R6einplGTNHopmkyA0AD0g0yaGn+YhcTIUQm0bddIIrasy+lamDT2c/c+05hMahM9CNDmIq
HXOZIoptgH1xl+yTZJsEJiEgQYAAHLVWL4Xk2D8rGJugejsAeBAAAroAYQgYUS2Tim02nSDBppJE
JJHz4W8flEJZTH3zZidvq0XKr+4AGE4sRO1BbLkblFjmzQ/l3AELi/erLklS/Nv8OLevKw6iwAG5
i00NRUUoBFP6UcgRI64IgOhSR9hlFKdAQbCJQyNUZb0JwGAllLCWAgZtVm0gxLRMdhM52qjvh7oX
c9YPj2VlxFQ60V5c1HRBBo/WShMMlvnxBcYznyCLZNeOeQk39QkUzv9rgB3WCFVG7cRdoS7CNVqd
Sg2sWENtPdAwwSwYTV7jNC6E0F+OmkW9uvEdJcoibN6SE0WnCkBK8KSclkIeGq2GpMKCplYkZPa0
Z7TXYbwq6iBTA3Uundajec20anH+Dcsm1pKaSalkZuM1Gwmie9yGhbpXJQWoUxqSQhO/R2Nwi+mf
eEAb8idp7WabcS9HeIcW4hAFest7HpbjkXDVhzUwKvQ2oIUQKTh0ECJSQGmWGBpaZHUBbTMMJsiI
A0wImQGVOppMHqTrBhZMy8iOHEI97BZGRXt3b7u7sTm7MYHQxOOQCEYRIBAIyMBhJAkQiMipt1ez
PXp43A06tFVrfN8KEBgqxmAATVNpBXDRDaAgVXUQkaSo++7TuP6IxxeWlrLs4ZzyysWJVmchLVWs
RnMgry0h4GAxPcrNoBFXxkCoMvJ8336bxscAvXeQ/SDPHNVlIOcKGo0wogcJhayXQJ1W1dOTudZ0
xNwXkLcnKJReEIgwuKRMTl6AA1wASjxF9U6IFRGhULPFjvy251wdk1KukkPIE8wUETIK9qgB7WIM
cObjjiJJEIsSQYGEpzDDgdbJSHI5GWNdkwlc4RDRUkgyTmwVpTREAKOdB2q+NBAMa9TUe/7c+pBj
wzIcdtndlVJC5buRiW8zG0gkWhAnjyZ3ww05ZHy+VqWp0YeedAQbSYpYCDhQbgEA4LZa4NtQsLWn
4AWMnjHR3+bu8HwObnfPwq/BUdMLUsUrPClsMZ1pE3FZWU5SrUrSuOFsa2pmdsSF0G3mX1DFf6D3
MIaGol/F3JFOFCQjOQHowA==

--=-CXU8AE1bNA946FwboHoc--

