Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTLNQTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 11:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTLNQTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 11:19:25 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:9371
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262115AbTLNQTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 11:19:24 -0500
Date: Sun, 14 Dec 2003 11:27:28 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031214112728.A8201@animx.eu.org>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl> <20031212163545.A26866@animx.eu.org> <20031213132208.GA11523@win.tue.nl> <20031213171800.A28547@animx.eu.org> <20031214144046.GA11870@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20031214144046.GA11870@win.tue.nl>; from Andries Brouwer on Sun, Dec 14, 2003 at 03:40:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The script does use sfdisk to aquire the size and the user tells it just how
> > large the partition to be and defaulting to the largest possible.  If the
> > geometry is wrong, the other OS won't boot.
> 
> What interests me is: do you need varying geometry?
> That is: do you sometimes need */16/63 and sometimes */255/63
> or even other values?
> 
> Or does it suffice to take */255/63 always?

I would say most cases use the 255/63, but I'm not 100% sure on that, just
with drives >4gb.  Is there anyway to query the bios to ask it?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
