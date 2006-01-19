Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161459AbWASWbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161459AbWASWbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161460AbWASWbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:31:19 -0500
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:35297 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S1161459AbWASWbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:31:18 -0500
Date: Thu, 19 Jan 2006 23:31:14 +0100
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 3c59x went nuts between .15-mm3 and .15-mm4
Message-ID: <20060119223114.GN16047@bayes.mathematik.tu-chemnitz.de>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060119225345.18a570ae@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119225345.18a570ae@werewolf.auna.net>
User-Agent: Mutt/1.4.2.1i
X-Spam-Score: -1.4 (-)
X-Spam-Report: --- Start der SpamAssassin 3.1.0 Textanalyse (-1.4 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-1.4 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner
	weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: e90a451e269f6704296cddf3d75231cf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The related patch had some (I think duplex related) 
issues with setting up certain NICs. It's reverted in 2.6.16-rc1-mm1.
I'm about to work out the problems of this patch.

The driver version did not increase since more than three years.
But perhaps it is a good idea to maintain the driver version. 

Steffen

On Thu, Jan 19, 2006 at 10:53:45PM +0100, J.A. Magallon wrote:
> Hi all...
> 
> I can't use 2.6.15-mm4 on one of my boxes because it renders the 3Com NIC
> broken. No network connection. This is a 3c905C-TX/TX-M [Tornado] (rev 74).
> On one other box, I have a 3c980-C 10/100baseTX NIC [Python-T] (rev 78),
> driven also with 3c59x, that goes also deafmute.
> I have seen the changes between -mm3 and -mm4, and looks like a rewrite
> to use mii instead of homebrew code (btw, should not this increase the
> driver version number ?). But something there broke (or, as usual, some
> change in ACPI...).
> 
...

