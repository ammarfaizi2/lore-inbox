Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266083AbUAFEcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUAFEcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:32:32 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:14005 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266083AbUAFEcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:32:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: john stultz <johnstul@us.ibm.com>, Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: [2.6.0-mm2] PM timer still has problems
Date: Mon, 5 Jan 2004 23:32:24 -0500
User-Agent: KMail/1.5.4
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20031230204831.GA17344@hell.org.pl> <1073340716.15645.96.camel@cog.beaverton.ibm.com>
In-Reply-To: <1073340716.15645.96.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401052332.24739.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 January 2004 05:11 pm, john stultz wrote:

> If the override boot option failed, its most likely your system doesn't
> have an ACPI PM time source.  Instead it seems your system is having
> trouble using the PIT as a time source (which seems not all that
> uncommon unfortunately).
>

Or that Karol's laptop has ACPI PM timer that is accessed through the
memory (ACPI_ADR_SPACE_SYSTEM_MEMORY), is there such implementations?
Right now timer_pm.c only supports IO-port based timer access.

Dmitry
 

