Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTFCTVC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTFCTVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:21:02 -0400
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:39691 "EHLO centaur")
	by vger.kernel.org with ESMTP id S262709AbTFCTVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:21:01 -0400
Subject: [2.5.70-bk-20030603] oldconfig always asking for machine type (x86)
From: Witold Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1054668864.12364.8.camel@samael.culm.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2.99 (Preview Release)
Date: 03 Jun 2003 21:34:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On today snap of 2.5.70 from linux-2.5 bk tree while making make
oldconfig I always get:
Subarchitecture Type
> 1. PC-compatible (X86_PC)
  2. Voyager (NCR) (X86_VOYAGER)
  3. NUMAQ (IBM/Sequent) (X86_NUMAQ)
  4. SGI 320/540 (Visual Workstation) (X86_VISWS)
choice[1-4]:
Even if I'm doing this once after another, this a lil' bit complicates
creating binary packages with kernel, as building it should not wait for
any user input/interaction.
WK

