Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTDFPMz (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbTDFPMz (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:12:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20110
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262993AbTDFPMy (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 11:12:54 -0400
Subject: Re: poweroff problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030406174655.592b7f60.us15@os.inf.tu-dresden.de>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>
	 <20030406233319.042878d3.sfr@canb.auug.org.au>
	 <20030406155814.68c5c908.us15@os.inf.tu-dresden.de>
	 <20030407002703.16993dc4.sfr@canb.auug.org.au>
	 <20030406174655.592b7f60.us15@os.inf.tu-dresden.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049639095.963.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 15:24:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 16:46, Udo A. Steinberg wrote:
> On Mon, 7 Apr 2003 00:27:03 +1000 Stephen Rothwell (SR) wrote:
> 
> SR> I was asuming the original report was from a kernel using APM not ACPI.
> SR> Did 2.4.2 have ACPI?
> 
> Err no, so he must have been using APM.
> 
> 2.4.2+APM has the problem, 2.4.21-pre+ACPI has the problem. Do APM and
> ACPI both share the same code to power off a machine? If so that seems to
> be the culprit.

We rely on the bios for the power off sequences. Many BIOS vendors do
set it up to share the bios code it seems

