Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290292AbSAXINt>; Thu, 24 Jan 2002 03:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290295AbSAXINl>; Thu, 24 Jan 2002 03:13:41 -0500
Received: from khms.westfalen.de ([62.153.201.243]:61406 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S290292AbSAXINb>; Thu, 24 Jan 2002 03:13:31 -0500
Date: 24 Jan 2002 08:59:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8HSVvR$1w-B@khms.westfalen.de>
In-Reply-To: <a2kac1$m0a$1@cesium.transmeta.com>
Subject: Re: Why not "attach" patches?
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <a2kac1$m0a$1@cesium.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin)  wrote on 22.01.02 in <a2kac1$m0a$1@cesium.transmeta.com>:

> The common ground most people seems to be able to accept is:
>
> a. Go ahead and make patches as attachments, if your MUA makes it easier;
> b. Be bloody certain they're text/plain attachments.

... and that they have Content-Transfer-Encoding: 7bit or 8bit.

*Not* quoted-printable or base64.

Which means that you lose if the patch contains chars whose 8th bit is  
set, if any MTA between you and Linus/Alan/etc. doesn't like that. Which  
is not quite unlikely. (But most MUAs won't allow you to send something  
like that anyway.)

MfG Kai
