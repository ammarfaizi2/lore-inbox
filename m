Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbVICOCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbVICOCc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 10:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVICOCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 10:02:32 -0400
Received: from mail.solid.co.at ([193.83.215.58]:44738 "EHLO
	mail.solid-soft.at") by vger.kernel.org with ESMTP id S1751458AbVICOCb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 10:02:31 -0400
Message-ID: <4319ACF1.7050307@solid-soft.at>
Date: Sat, 03 Sep 2005 16:02:25 +0200
From: Robert Valentan <R.Valentan@solid-soft.at>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: john@stoffel.org, linux-scsi@vger.kernel.org
Subject: Re: SCSI tape problems...   (solved?)
References: <430B73E9.7080207@solid-soft.at>
In-Reply-To: <430B73E9.7080207@solid-soft.at>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I think, I have found the problem with SCSI-Tapes
(Error 80000).
I have detect, that the sgraidmon is testing all sg-devices,
and if the inquiry-command fails (timeout) it sends a bus-
reset-command (ioctl) as "recovery"-operation !
After stopping the sgraidmon I have no more problems with
the tape.

Can anybody confirm this?


-- 
Robert Valentan
