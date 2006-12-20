Return-Path: <linux-kernel-owner+w=401wt.eu-S964916AbWLTHul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWLTHul (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 02:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbWLTHul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 02:50:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43019 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbWLTHuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 02:50:40 -0500
Subject: Re: Changes to PM layer break userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Greg KH <gregkh@suse.de>, David Brownell <david-b@pacbell.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061220055209.GA20483@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org>
	 <200612191959.43019.david-b@pacbell.net>
	 <20061220042648.GA19814@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de>
	 <20061220055209.GA20483@srcf.ucam.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 08:50:24 +0100
Message-Id: <1166601025.3365.1345.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Seriously. How many pieces of userspace-visible functionality have 
> recently been removed without there being any sort of alternative?

There IS an alternative, you're using it for networking:
 
You *down the interface*.

If there's a NIC that doesn't support that let us (or preferably netdev)
know and it'll get fixed quickly I'm sure.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

