Return-Path: <linux-kernel-owner+w=401wt.eu-S932258AbXAIRdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbXAIRdW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbXAIRdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:33:22 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:41818 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258AbXAIRdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:33:21 -0500
Message-ID: <45A3D1DF.4020205@s5r6.in-berlin.de>
Date: Tue, 09 Jan 2007 18:33:19 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
>   just to stir the pot a bit regarding the discussion of the two
> different ways to define macros,

You mean function-like macros, right?

> i've just noticed that the "({ })"
> notation is not universally acceptable.  i've seen examples where
> using that notation causes gcc to produce:
> 
>   error: braced-group within expression allowed only inside a function

And function calls and macros which expand to "do { expr; } while (0)"
won't work anywhere outside of functions either.

> i wasn't aware that there were limits on this notation.  can someone
> clarify this?  under what circumstances *can't* you use that notation?
> thanks.

The limitations are certainly highly compiler-specific.
-- 
Stefan Richter
-=====-=-=== ---= -=--=
http://arcgraph.de/sr/
