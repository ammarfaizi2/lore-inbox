Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTDOMEZ (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTDOMEZ 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:04:25 -0400
Received: from arnold.dormnet.his.se ([193.10.185.236]:61702 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP id S261294AbTDOMEY 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:04:24 -0400
Date: Tue, 15 Apr 2003 14:15:18 +0200
From: Andreas Henriksson <andreas@fjortis.info>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing modules for 2.5
Message-ID: <20030415121517.GA23894@foo>
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel> <p73adesxane.fsf@oldwotan.suse.de> <yw1xllyc7yoz.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xllyc7yoz.fsf@zaphod.guide>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 02:05:48PM +0200, Måns Rullgård wrote:
> Next question:  what is the correct replacement for MOD_INC_USE_COUNT?

"SET_MODULE_OWNER(dev);" or simply "dev->owner=THIS_MODULE;" and the
counting should then be done automatically AFAIK.

> -- 
> Måns Rullgård
> mru@users.sf.net

Regards,
Andreas Henriksson
