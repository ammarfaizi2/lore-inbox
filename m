Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUA0PMf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUA0PMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:12:35 -0500
Received: from upco.es ([130.206.70.227]:17583 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S263927AbUA0PMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:12:32 -0500
Date: Tue, 27 Jan 2004 16:12:30 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: linux-kernel@vger.kernel.org
Subject: Half-success: acpi swsusp in stock 2.6.1 on a vaio PGC-FX701 laptop
Message-ID: <20040127151230.GA22312@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all, 

   this mail is to tell you about an half-success. I am trying to run a
2.6.1 (stock) kernel with my vaio pgc-fx701 laptop running Mandrake 9.2.I am
in the phase of trying to have the suspend option working. The stock kernel
swsusp "almost" work: it suspend the laptop, it resume it almost ok: but
neither usb mouse nor alsa works in the resumed machine. Ethernet works. 

    I read on the kernel-list archive of the possibility of unload/reloading
the drivers on resume, but I have another problem: compiling the "module
unloading" option in the kernel make kudzu generate an oops at early boot
stage. 

    So, before continuing: can I help with debugging? Or all these problems
are  well-known and simply I have to wait for the 2.6.2 kernel? If you need
the above-mentioned early oops, tell me; I will try to reproduce it and copy
it by hand (it was not so long; EIP was invalid, so...) 

    Romano 


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
