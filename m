Return-Path: <linux-kernel-owner+w=401wt.eu-S932838AbWL0OYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbWL0OYd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 09:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWL0OYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 09:24:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55780 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932838AbWL0OYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 09:24:32 -0500
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and
	2.6.x kernels
From: Arjan van de Ven <arjan@infradead.org>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <666716.84435.qm@web32603.mail.mud.yahoo.com>
References: <666716.84435.qm@web32603.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 27 Dec 2006 15:24:30 +0100
Message-Id: <1167229470.3281.3905.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 06:16 -0800, Martin Knoblauch wrote:
> Hi, (please CC on replies, thanks)
> 
>  for the ganglia project (http://ganglia.sourceforge.net/) we are
> trying to find a heuristics to determine the number of physical CPU
> "cores" as opposed to virtual processors added by enabling HT. The
> method should work on 2.4 and 2.6 kernels.

I have a counter question for you.. what are you trying to do with the
"these two are SMT sibblings" information ?

Because I suspect "HT" is the wrong level of detection for what you
really want to achieve....

If you want to decide "shares caches" then at least 2.6 kernels directly
export that (and HT is just the wrong way to go about this). 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

