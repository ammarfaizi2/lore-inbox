Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262795AbTDATta>; Tue, 1 Apr 2003 14:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbTDATta>; Tue, 1 Apr 2003 14:49:30 -0500
Received: from smtp-out.comcast.net ([24.153.64.116]:62472 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S262795AbTDATt3>;
	Tue, 1 Apr 2003 14:49:29 -0500
Date: Tue, 01 Apr 2003 14:55:14 -0500
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: [Bug 529] New: ACPI under 2.5.50+ (approx) locks system hard
	during bootup
In-reply-to: <20030401114749.A7647@figure1.int.wirex.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: chris@wirex.com, andrew.grover@intel.com
Reply-to: Matthew Harrell 
	  <mharrell-dated-1049658915.d5a407@bittwiddlers.com>
Message-id: <20030401195514.GA29214@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Delivery-Agent: TMDA/0.68 (Shut Out)
X-Primary-Address: mharrell@bittwiddlers.com
References: <130680000.1049224849@flay>
 <20030401114749.A7647@figure1.int.wirex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've tried every kernel I could get to build up through 2.5.66 and nothing 
changed.  Same behavior every time

Also, I can get them all to boot into single user mode.  I'm going to check
if the hang is caused by the loading of the alsa modules (which run on the
same interrupt) or something else.



: Try >= 2.5.64.  It has a derive_pci_id ACPI patch that fixed this problem
: for me[*].
: 
: ChangeSet@1.889.255.2, 2003-02-26 13:47:36-08:00, agrover@groveronline.com
:   ACPI: Fix derive_pci_id (Ducrot Bruno, Alvaro Lopez)
: 
: thanks,
: -chris
: 
: [*] There is still a case where a warm reboot from a 2.4 kernel will
: hang, but warm reboot from 2.5 kernel, or cold boot no longer hangs.
: -- 
: Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

-- 
  Matthew Harrell                          I love defenseless animals,
  Bit Twiddlers, Inc.                       especially in a good gravy.
  mharrell@bittwiddlers.com     
