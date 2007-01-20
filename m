Return-Path: <linux-kernel-owner+w=401wt.eu-S1750786AbXATWyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbXATWyM (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 17:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbXATWyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 17:54:11 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:3215 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbXATWyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 17:54:10 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
Date: Sat, 20 Jan 2007 14:54:10 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEKNBAAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <c384c5ea0701201007t4e637b9eh133101286ce5598d@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 20 Jan 2007 15:56:36 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 20 Jan 2007 15:56:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nice observation, however, it still leaves quite an amount of internal
> inconsistencies in the kernel output.

	I agree with the majority view that using the term 'MB' or 'GB' to mean a
million or a billion bytes is inaccurate. The way RAM and flash are measured
is correct. The way disk manufacturers advertise disk capacity is simply
*wrong*. There is no word for a million bytes. There is no word for a
billion bytes.

> One way of getting rid of those inconsistencies would be to follow IEC
> 60027-2 for those cases where SI is inappropriate.

	Talk about a cure worse than the disease! So you're saying that 256MB flash
cards could be advertised as having 268.4MB? A 512MB RAM stick is
mislabelled and could correctly say 536.8MB? That's just plain craziness.

	Adopting IEC 60027-2 just replaces a set of well-understood problems with
all new problems.

	DS


