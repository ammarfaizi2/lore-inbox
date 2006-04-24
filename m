Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWDXRqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWDXRqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWDXRqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:46:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56472 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751041AbWDXRqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:46:31 -0400
Subject: RE: [ANNOUNCE] Release Digsig 1.5: kernel module
	forrun-timeauthentication of binaries
From: Arjan van de Ven <arjan@infradead.org>
To: "Makan Pourzandi (QB/EMC)" <makan.pourzandi@ericsson.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       disec-devel@lists.sourceforge.net
In-Reply-To: <6D19CA8D71C89C43A057926FE0D4ADAA29D363@ecamlmw720.eamcs.ericsson.se>
References: <6D19CA8D71C89C43A057926FE0D4ADAA29D363@ecamlmw720.eamcs.ericsson.se>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 19:46:28 +0200
Message-Id: <1145900788.3116.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  And, IMO, it should
> be used with other security mechanisms and not alone. I believe though
> this simple functionality can do much to avoid executing viruses or
> other malware on your system.   

that I don't believe for a second unfortunately.
It's really really trivial to just do a shar archive or similar that
then executes the binary... or otherwise "pack" the elf binary in such a
way that it bypasses your check. 

If you said "this is for DRM purposes" I could buy that partially.
But... to protect against malware? Not at all. Not even a little bit.
There's so many ways on normal systems to bypass this that malware
doesn't even suffer one tiny bit from this.


