Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbTDOMqo (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbTDOMqo 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:46:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45323 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261349AbTDOMqm (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 08:46:42 -0400
Date: Tue, 15 Apr 2003 13:58:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andreas Henriksson <andreas@fjortis.info>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Writing modules for 2.5
Message-ID: <20030415135829.D32468@flint.arm.linux.org.uk>
Mail-Followup-To: Andreas Henriksson <andreas@fjortis.info>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel> <p73adesxane.fsf@oldwotan.suse.de> <yw1xllyc7yoz.fsf@zaphod.guide> <20030415121517.GA23894@foo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030415121517.GA23894@foo>; from andreas@fjortis.info on Tue, Apr 15, 2003 at 02:15:18PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 02:15:18PM +0200, Andreas Henriksson wrote:
> On Tue, Apr 15, 2003 at 02:05:48PM +0200, Måns Rullgård wrote:
> > Next question:  what is the correct replacement for MOD_INC_USE_COUNT?
> 
> "SET_MODULE_OWNER(dev);" or simply "dev->owner=THIS_MODULE;" and the
> counting should then be done automatically AFAIK.

You don't need that for char drivers.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

