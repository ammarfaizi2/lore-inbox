Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTFERwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbTFERwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:52:14 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:46210
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263722AbTFERwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:52:13 -0400
Date: Thu, 5 Jun 2003 13:54:56 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Brian J. Murrell" <brian@interlinx.bc.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
In-Reply-To: <Pine.GSO.3.96.1030605141622.5828F-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.50.0306051352500.3503-100000@montezuma.mastecende.com>
References: <Pine.GSO.3.96.1030605141622.5828F-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jun 2003, Maciej W. Rozycki wrote:

>  You may have a valid SMP table and discrete local APICs (i82489DX) which
> are not reported in CPU capability bits.  The "nolocalapic" option should
> handle them, too.  Otherwise it would be a surprising inconsistency. 

Good point, out of interest, have you come across broken system like that? 
Regardless i'll update the patch.

Thanks,
	Zwane
-- 
function.linuxpower.ca
