Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbTGBMyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 08:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbTGBMyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 08:54:10 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:53403 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264991AbTGBMyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 08:54:07 -0400
Date: Wed, 2 Jul 2003 14:10:47 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: ffrederick@prov-liege.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Washing suspend code
Message-ID: <20030702131047.GA9779@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	ffrederick@prov-liege.be, linux-kernel@vger.kernel.org
References: <S263945AbTGBIGc/20030702080632Z+4079@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S263945AbTGBIGc/20030702080632Z+4079@vger.kernel.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 10:43:11AM +0200, ffrederick@prov-liege.be wrote:
 >  }
 > +int touchable_process (struct task_struct *p)
 > +{
 > +	return(!((p->flags & PF_IOTHREAD) || (p == current) || (p->state == TASK_ZOMBIE)))
 > +
 > +}

*horror*. Please keep the formatting of the original macro.
It's a) more readable, and b) Documentation/CodingStyle compliant.

		Dave

