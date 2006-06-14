Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWFNFJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWFNFJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWFNFJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:09:50 -0400
Received: from mail.gmx.de ([213.165.64.21]:41190 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964865AbWFNFJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:09:49 -0400
X-Authenticated: #14349625
Subject: RE: process starvation with 2.6 scheduler
From: Mike Galbraith <efault@gmx.de>
To: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Radjendirane Codandaramane 
	<Radjendirane_Codandaramane@pmc-sierra.com>
In-Reply-To: <478F19F21671F04298A2116393EEC3D531CEA4@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
References: <478F19F21671F04298A2116393EEC3D531CEA4@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 07:13:17 +0200
Message-Id: <1150261998.8611.14.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 16:03 -0700, Kallol Biswas wrote:
> It seems that with the priority set to 19 the netserver processes do not starve but still we have unfair scheduling issue. The netperf clients do not timeout now but one of the servers runs much less than the other. It seems that thorough understanding of scheduling algorithm is essential at this point.

Are the clients all on one box?

	-Mike

