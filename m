Return-Path: <linux-kernel-owner+w=401wt.eu-S1755020AbWL2PpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbWL2PpV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 10:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbWL2PpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 10:45:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36770 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013AbWL2PpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 10:45:20 -0500
Subject: Re: KVM ... bypass BIOS check for VT?
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <b6a2187b0612290714g4ce65aa2n82752ae73e651a38@mail.gmail.com>
References: <b6a2187b0612290714g4ce65aa2n82752ae73e651a38@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 29 Dec 2006 16:45:18 +0100
Message-Id: <1167407118.20929.278.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-29 at 23:14 +0800, Jeff Chua wrote:
> I'm resending this under KVM as a subject and hope to get response.
> 
> kvm: disabled by bios
> 
> I know this has been asked before and the answer was no. Does it still
> stand or is there a way to bypass the bios? I'm using Lenovo X60s and
> there's no option to enable VT in the BIOS setup.

I don't think there is a generic way that works.
(rationale: the bios really has to support VT, for example it has to
load the right microcode into the cpu etc)

Not ruling out that specific machines may be able to force it, but
that's more luck than a general solution if that's the case.

(fwiw the linux-ready firmware developer kit now has a test for
vt-enabling so with some luck more bioses will have this right in the
future)

Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

