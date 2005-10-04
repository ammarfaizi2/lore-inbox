Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVJDWMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVJDWMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVJDWMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:12:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:64180 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965008AbVJDWMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:12:36 -0400
Subject: Re: clock skew on B/W G3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc <marvin24@gmx.de>
Cc: Rune Torgersen <runet@innovsys.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200510040814.07188.marvin24@gmx.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
	 <200510040814.07188.marvin24@gmx.de>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 08:10:19 +1000
Message-Id: <1128463821.6417.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 08:14 +0200, Marc wrote:
> Hi,
> 
> given that this option causes problems on non i386 systems, may I propose to 
> mark CONFIG_HZ as broken on these architectures and/or use a default value of 
> 1000 ? I guess this issue can't be fixed in a sane way until 2.6.14 is out.

No, it should work fine, there is something else broken on this G3

Ben.


