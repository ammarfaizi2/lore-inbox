Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Sieve: Server Sieve 2.2
thread-index: AcQ3zVJErHtSIADhR7uzTmx5OXUh/g==
X-Sieve: Server Sieve 2.2
From: <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: <Administrator@osdl.org>
Cc: <akpm@osdl.org>, <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Message-ID: <000201c437cf$71273790$d100000a@sbs2003.local>
Subject: Re: [PATCH 1/2] PPC32: New OCP core support 
In-Reply-To: Your message of "Tue, 11 May 2004 18:01:44 PDT."             <20040511180144.A4901@home.com> 
References: <20040511170150.A4743@home.com> <200405120039.i4C0dHs0010426@turing-police.cc.vt.edu>            <20040511180144.A4901@home.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Date: Wed, 12 May 2004 04:15:56 +0100
Content-Type: text/plain;
	charset="us-ascii"
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Content-Class: urn:content-classes:message
X-me-spamlevel: not-spam
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.132
X-OriginalArrivalTime: 12 May 2004 03:00:46.0171 (UTC) FILETIME=[524B5AB0:01C437CD]
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-me-spamlevel: not-spam
Priority: normal
X-me-spamrating: 0.006940



On Tue, 11 May 2004 18:01:44 PDT, Matt Porter said:

> Actually, OCP stands for On-Chip Peripheral and is the basic system
> we've used in ppc32 for some time now to abstract dumb peripherals
> behind a standard API. BenH did yet another rewrite of OCP in 2.4
> sometime ago and I picked up that work to port to 2.6 and the new
> device model. It is a software abstraction, and easily allows us to
> plug in SoC descriptors when new chips come out and use standard apis
> to modify device entries on a per-board basis during "setup_arch()
> time". It used to be PPC4xx-specific, but now is being used by
> PPC85xx, MV64xxx, and MPC52xx based PPC systems. "Now", meaning that
> the respective developers for those parts are using the OCP working
> tree to base their 2.6 ports off of.

Wrap a /* */ around that paragraph and add it to the top of ppc/syslib/ocp.c :)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


