Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTFYLMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 07:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTFYLMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 07:12:47 -0400
Received: from mail009.syd.optusnet.com.au ([210.49.20.137]:22201 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264465AbTFYLMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 07:12:46 -0400
Date: Wed, 25 Jun 2003 21:25:34 +1000
To: Roman Zippel <zippel@linux-m68k.org>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [trivial 2.5] kconfig language doc r.e. --help--
Message-ID: <20030625112534.GB9295@cancer>
References: <20030625084309.GA9295@cancer> <Pine.LNX.4.44.0306251246240.11817-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306251246240.11817-100000@serv>
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 12:48:43PM +0200, Roman Zippel wrote:
> Where did you find the '--help--' version? I'm actually suprised that 
> works. The official alternative is only '---help---'.

I'd *swear* i saw '--help--' yesterday. I'd swear until i was a
light shade of blue....  

Oh well, patch that only references "---help---" below.


--- linux-2.5.73/Documentation/kbuild/kconfig-language.txt	2003-06-15 17:47:18.000000000 +1000
+++ linux-2.5.73-stew1/Documentation/kbuild/kconfig-language.txt	2003-06-25 21:24:28.000000000 +1000
@@ -105,10 +105,13 @@
   or equal to the first symbol and smaller than or equal to the second
   symbol.
 
-- help text: "help"
+- help text: "help" or "---help---"
   This defines a help text. The end of the help text is determined by
   the indentation level, this means it ends at the first line which has
   a smaller indentation than the first line of the help text.
+  "---help---" and "help" do not differ in behaviour, "---help---" is
+  used to help visually seperate configuration logic from help within
+  the file as an aid to developers.
 
 
 Menu dependencies


-- 
Stewart Smith
Vice President, Linux Australia
http://www.linux.org.au (personal: http://www.flamingspork.com)
