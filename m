Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTDHVHx (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbTDHVHx (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:07:53 -0400
Received: from AMarseille-201-1-5-161.abo.wanadoo.fr ([217.128.250.161]:39463
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261773AbTDHVHw (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 17:07:52 -0400
Subject: Re: *  2.5.67 sleep function from illegal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Balram Adlakha <b_adlakha@softhome.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1049832651.592.3.camel@teapot.felipe-alfaro.com>
References: <200304082340.06746.b_adlakha@softhome.net>
	 <1049832651.592.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049836790.559.17.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Apr 2003 23:19:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-08 at 22:10, Felipe Alfaro Solana wrote:
> On Wed, 2003-04-09 at 01:40, Balram Adlakha wrote:
> > I get this repeatedly each second:
> > 
> > 
> > Debug: sleeping function called from illegal context at mm/slab.c:1658
> > 

Known bug in fbcon, fixed in latest version from James Simmons
that should get in soon.

Ben.

