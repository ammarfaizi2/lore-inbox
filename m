Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbTDOMS5 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTDOMS5 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:18:57 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:53889
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S261302AbTDOMS4 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:18:56 -0400
To: Andreas Henriksson <andreas@fjortis.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing modules for 2.5
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel>
	<p73adesxane.fsf@oldwotan.suse.de> <yw1xllyc7yoz.fsf@zaphod.guide>
	<20030415121517.GA23894@foo>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 15 Apr 2003 14:30:01 +0200
In-Reply-To: <20030415121517.GA23894@foo>
Message-ID: <yw1xhe907xkm.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Henriksson <andreas@fjortis.info> writes:

> > Next question:  what is the correct replacement for MOD_INC_USE_COUNT?
> 
> "SET_MODULE_OWNER(dev);" or simply "dev->owner=THIS_MODULE;" and the
> counting should then be done automatically AFAIK.

OK, but what might dev be and when should this be done?  What about
MOD_DEC_USE_COUNT?

-- 
Måns Rullgård
mru@users.sf.net
