Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTFBLq3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 07:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTFBLq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 07:46:28 -0400
Received: from cpmail5.sol.no1.asap-asp.net ([195.225.3.232]:8941 "HELO
	cpmail5.sol.no1.asap-asp.net") by vger.kernel.org with SMTP
	id S262251AbTFBLq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 07:46:26 -0400
Date: Mon, 2 Jun 2003 14:59:35 +0300
Message-ID: <3E5AD46C00070B27@webmail-fi1.sol.no1.asap-asp.net>
In-Reply-To: <1054496549.943.5.camel@teapot.felipe-alfaro.com>
From: zipa24@suomi24.fi
Subject: Re: 2.5.70-mm3
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Did you compile the kernel with gcc 3.2 or later?
>I had a very, very similar oops on my laptop with the snd-ymfpci driver
>if I compiled the kernel with gcc 3.2.3. Reverting back to gcc 2.96
>solved the problem.

After you suggestion I tried gcc 3.3 and gcc 2.95.3 but I got the same OOPS
as with the original (gcc 3.2.2) version.

There is a new ALSA patch available, but it didn't apply cleanly to -mm3.
If I have time later today I'll see if I can apply only ymfpci-related changes
and if they help.

// /

_____________________________________________________________
Kuukausimaksuton nettiyhteys: http://www.suomi24.fi/liittyma/
Yli 12000 logoa ja soitto‰‰nt‰: http://sms.suomi24.fi/


