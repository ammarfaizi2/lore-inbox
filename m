Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVBCImT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVBCImT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVBCImS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:42:18 -0500
Received: from canuck.infradead.org ([205.233.218.70]:64007 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262860AbVBCIlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:41:06 -0500
Subject: Re: Please open sysfs symbols to proprietary modules
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 09:41:00 +0100
Message-Id: <1107420060.4278.88.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 17:56 -0500, Pavel Roskin wrote:
> Hello!
> 
> I'm writing a module under a proprietary license.  I decided to use sysfs 
> to do the configuration.  Unfortunately, all sysfs exports are available 
> to GPL modules only because they are exported by EXPORT_SYMBOL_GPL.

I suggest you talk to a lawyer and review the general comments about
binary modules with him (http://people.redhat.com/arjanv/COPYING.modules
for example). You are writing an addition to linux from scratch, and it
is generally not considered OK to do that in binary form (I certainly do
not consider it OK).



