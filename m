Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264837AbTFBSfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTFBSfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:35:40 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:45986 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264837AbTFBSff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:35:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16091.39943.112937.183523@gargle.gargle.HOWL>
Date: Mon, 2 Jun 2003 14:48:39 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: thunder7@xs4all.nl
Cc: Josh Litherland <josh@temp123.org>, linux-kernel@vger.kernel.org
Subject: Re: Working UP IOAPIC ?
In-Reply-To: <20030602174322.GA26533@middle.of.nowhere>
References: <20030602173231.GA10363@temp123.org>
	<20030602174322.GA26533@middle.of.nowhere>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jurriaan" == Jurriaan  <thunder7@xs4all.nl> writes:

Jurriaan> From: Josh Litherland <josh@temp123.org>
Jurriaan> Date: Mon, Jun 02, 2003 at 12:32:31PM -0500
>> Are there any mainboards for AMD Thoroughbred core on which the UP
>> IOAPIC works with Linux?  I've tried several, all have had floods of
>> APIC error (02) and (00), and I understand from previous postings that
>> this indicates my APIC bus is buggy.
>> 

Jurriaan> My Epox 8K9A3+ works perfectly with it's APIC, as long as I
Jurriaan> don't use ACPI, that is. I'm using a XP2400, this board has
Jurriaan> a VIA KT400 chipset.

Thanks for the hint!  I turned off ACPI on my Dell SMP box and now I
can run UP with APIC turned on.  Just now re-compiling to have IO-APIC
on UP as a test, then on to SMP mode testing.  

John
