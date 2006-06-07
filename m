Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWFGFY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWFGFY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 01:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWFGFY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 01:24:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:65478 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750850AbWFGFY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 01:24:29 -0400
X-Authenticated: #14349625
Subject: RE: process starvation with 2.6 scheduler
From: Mike Galbraith <efault@gmx.de>
To: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <478F19F21671F04298A2116393EEC3D527431D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
References: <478F19F21671F04298A2116393EEC3D527431D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 07:27:25 +0200
Message-Id: <1149658045.8439.18.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 14:58 -0700, Kallol Biswas wrote:
> Thanks for help. We do not see the issue if every netserver's priority is set to 19 with setpriority() call.

FYI, there have been changes to the scheduler since 2.6.11 days that
reduce the likelihood of this scenario somewhat.

	-Mike

