Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272438AbTGaIjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 04:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272440AbTGaIjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 04:39:18 -0400
Received: from main.gmane.org ([80.91.224.249]:27022 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S272438AbTGaIjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 04:39:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Disk performance degradation
Date: Thu, 31 Jul 2003 10:35:24 +0200
Message-ID: <yw1xy8yf3xgz.fsf@users.sourceforge.net>
References: <20030729182138.76ff2d96.lista1@telia.com> <3F26A5E2.4070701@aros.net>
 <Pine.LNX.4.56.0307301658030.30842@router.windsormachine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:B7jZMe3fKi/pMlt6Tc/uzHb9anQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Dresser <mdresser_l@windsormachine.com> writes:

> Probably for reasons like that.  For some reason, I can't set my ICH4
> based controller(ASUS P4B533) and Quantum Fireball AS40.0 to more than
> 255.  Kernel is 2.4.21

It appears that in 2.[56] kernels the unit for readahead is bytes,
rather than sectors, as used in 2.4 kernels.

-- 
Måns Rullgård
mru@users.sf.net

