Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTICOqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbTICOqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:46:24 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:14610 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S262363AbTICOqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:46:19 -0400
To: Mathieu Chouquet-Stringer <mchouque@online.fr>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Compiling latest 2.6 bk snapshot on Alpha
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <20030903143157.GA17699@localhost>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Wed, 03 Sep 2003 16:40:31 +0200
Message-ID: <wrpznhm3pgg.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030903143157.GA17699@localhost> (Mathieu Chouquet-Stringer's
 message of "Wed, 3 Sep 2003 10:31:57 -0400")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Mathieu" == Mathieu Chouquet-Stringer <mchouque@online.fr> writes:

Mathieu> I've been hitting the same error every time I try to compile
Mathieu> bk current on alpha, namely the linker can't do its job on
Mathieu> .tmp_vmlinux1.  My compiler is "gcc version 3.2.3 (Debian)"
Mathieu> (but I also tried with 3.3 and 2.95), same problem.

Please check your binutils version. Here is the one I use, with great
success :

maz@panther:/mnt/i386/linux-2.5$ alpha-linux-ld --version
GNU ld version 2.13.90.0.18 20030121

	M.
-- 
Places change, faces change. Life is so very strange.
