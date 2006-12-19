Return-Path: <linux-kernel-owner+w=401wt.eu-S932876AbWLSSI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbWLSSI3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 13:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbWLSSI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 13:08:29 -0500
Received: from mail.wildbrain.com ([209.130.193.228]:57738 "EHLO
	hermes.wildbrain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932849AbWLSSI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 13:08:28 -0500
X-Greylist: delayed 939 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 13:08:28 EST
Message-ID: <458826E4.1030806@wildbrain.com>
Date: Tue, 19 Dec 2006 09:52:36 -0800
From: Gregory Brauer <greg@wildbrain.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Mikael Pettersson <mikpe@it.uu.se>, Roel.Teuwen@advalvas.be
Subject: Re: SATA300 TX4 + WD2500KS = status=0x50 { DriveReady SeekComplete
 }
References: <200612191424.kBJEO7bD007303@harpo.it.uu.se>
In-Reply-To: <200612191424.kBJEO7bD007303@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-WB-MailScanner: Found to be clean
X-WB-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=0.001, required 5, BAYES_50 0.00)
X-MailScanner-From: greg@wildbrain.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> I was looking briefly at the port mapping issue on 4-port Promise controllers
> yesterday and noticed a bit of programming magic in Promise's driver that
> Linux doesn't do, and which affects two of the four ports. That _could_
> explain your issues.
> 
> /Mikael

Just as a note, I filed the issue that this thread is about as a
kernel bug:

http://bugzilla.kernel.org/show_bug.cgi?id=7516

I am also experiencing the port-mapping issue you mention with
the SATA300 TX4, but I believe that the port mapping problem and
the excess status messages are separate and unrelated problems.

Greg
