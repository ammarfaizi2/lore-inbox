Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbWHMFVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWHMFVG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 01:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWHMFVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 01:21:05 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:47082 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932677AbWHMFVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 01:21:04 -0400
Message-Id: <6.1.1.1.2.20060813071741.02ae87e0@192.168.6.12>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Sun, 13 Aug 2006 07:20:46 +0200
To: linux-kernel@vger.kernel.org
From: Roger While <simrw@sim-basis.de>
Subject: Re: debug prism wlan
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-SIMBasis-MailScanner-Information: Please contact the ISP for more information
X-SIMBasis-MailScanner: Found to be clean
X-SIMBasis-MailScanner-From: simrw@sim-basis.de
X-ID: VmHfgkZpreCq5vgEa-5u-KguIE+3mEs7E3--6cSn9irW5d-oBHZxwt@t-dialin.net
X-TOI-MSGID: 9497c9cf-4105-4c47-b36c-605feef5ba2f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John wrote:
 > Daniel wrote:
 >> Hey, that did it! But now I am a liddle confused. It worked fine before.
 >> Why does it not work while interface is not up?

 > I'm not sure, but I think you've just been lucky.
 > I've had this problem even before prism54 was merged.
 > Some in-tree drivers won't upload the firmware until you ifconfig
 > up them, which obviously means they won't respond adequately
 > to the wireless extension requests. Maybe a bug?

Nope, no bug. It allows the driver to be built non-modular.
When non-modular, the resources are not available,
at boot time, to load the firmware.

Roger While


