Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUAOTQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUAOTQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:16:28 -0500
Received: from opersys.com ([64.40.108.71]:28933 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262078AbUAOTQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:16:26 -0500
Message-ID: <4006E812.7020007@opersys.com>
Date: Thu, 15 Jan 2004 14:20:50 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Philippe Gerum <rpm@xenomai.org>
Subject: [ANNOUNCE] RTAI 3.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[This is a forward of the announcement on the RTAI mailing list by
Philippe Gerum, the maintainer of RTAI 3.0 tree.]

The RTAI project is pleased to announce the release of the Real-Time
Application Interface version 3.0 (codenamed "kilauea"). RTAI is a
Free Software project aimed at developing a reliable and innovative
framework for programming real-time applications on GNU/Linux systems.

This new version of RTAI, which comes after a full year of continuous
development, supports five architectures, namely: x86, PPC, ARM, MIPS
and CRIS.

RTAI 3.0 features a streamlined and polished installation, leveraging
a new modular infrastructure, which brings an increased adaptability
to various software and hardware configurations.

Distributed real-time computing though the NETRPC middleware has
gained full symmetry between kernel and user-space APIs.

Traditional RTOS applications can now easily migrate to RTAI using one
of the available emulators, among which VRTX32/VRTXsa, pSOS+, VxWorks,
and uITRON-compliant "skins".

Development tools have also been improved, with a major revision of
RTAILab, and the release of a feature-rich simulator aimed at running
RTAI applications in a virtual environment.

With this 3rd major milestone, RTAI is also setting the groundwork for
a seamless integration of hard real-time processing into the standard
GNU/Linux programming model in user-space.

To this end, the LXRT support has been improved to the point where
most real-time applications can now run under MMU protection with the
required level of determinism.

Additionally, a preview of the new "fusion" technology is being made
available as part of this release. RTAI/fusion is the point of
convergence of several technologies including LXRT, Adeos, the
preemptible Linux kernel, and the low latency enhancements. It aims at
reinstating the RTAI applications into the regular GNU/Linux programming
model, allowing them to call Linux kernel services synchronously from
hard real-time tasks, while retaining a high degree of determinism.

RTAI 3.0 can be downloaded from the RTAI homepage at
http://www.aero.polimi.it/~rtai/

--

On a personal note, I would like to thank Paolo Mantegazza who, from
day one, has always supported and contributed to the major overhaul
which led to the 3.0 release (even at times when seeing a twirling
chain saw inside the venerable RTAI codebase must have been a bit
disturbing for him too! :o>) Many thanks also to the various
contributors and users who gave time and knowledge for making this
release happen.

-- Philippe.

