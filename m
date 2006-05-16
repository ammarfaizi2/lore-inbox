Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWEPTyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWEPTyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWEPTyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:54:55 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:62482 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750915AbWEPTyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:54:54 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <xavier.bestel@free.fr>
Cc: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Subject: RE: GPL and NON GPL version modules
Date: Tue, 16 May 2006 12:54:03 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEEDLPAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1147769525.25330.137.camel@capoeira>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 16 May 2006 12:50:02 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 16 May 2006 12:50:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unless the "someone else will release a GPL wrapper to my proprietary
> module" accident is planned from the start.
>
> 	Xav

	There certainly does seem to be some reason for suspicion.

	I would say that this doesn't matter so long as the two works are separate.
That is, two people could plan this from the start, act in concert, and
still be okay. However, they would have to make sure that nothing about the
GPL wrapper contaminates the proprietary module. That is, the proprietary
module must not in any way be designed to accomondate the GPL wrapper,
except perhaps in the form of generic accomodation for any wrapper.

	If the proprietary module contains any code that is designed specifically
to accomodate the GPL wrapper, the line is crossed. Whether or not that
consitutes a legal violation, however, is a complicated question.

	So long as the proprietary module was not designed to work with GPL'd code
(more than it's generically designed to work with other code of the same
type) and contains no GPL'd code, you should be okay. However, as soon as
any of the design of the proprietary code is intended to facilitate
interoperation with specific GPL'd code, you could start to get into
trouble.

	You should definitely consult a lawyer, but prepared for the answer,
"nobody really knows". They can chart out what is almost definitely safe and
what is almost definitely illegal, but there is a huge space in-between.

	DS


