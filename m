Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTIBEjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 00:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTIBEjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 00:39:51 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:32785 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263484AbTIBEju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 00:39:50 -0400
To: Richard van der Veen <rysh@home.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: tulip driver doesn't work in linux-2.6.0test4 for my
 Faralon Ethernet card
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <200309020429.15747.rysh@home.nl>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Tue, 02 Sep 2003 06:37:28 +0200
Message-ID: <wrpllt74xh3.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <200309020429.15747.rysh@home.nl> (Richard van der Veen's
 message of "Tue, 2 Sep 2003 04:29:15 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard van der Veen <rysh@home.nl> writes:

Richard> lspci (2.6.0test4)
Richard> ...
Richard> 00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
Richard> [Tulip Pass 3] (rev 21)
Richard> ...

Please use the de2104x driver (21040 and 21041 aren't handled by tulip
anymore).

        M.
-- 
Places change, faces change. Life is so very strange.
