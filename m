Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266286AbUANDkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 22:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUANDkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 22:40:15 -0500
Received: from amdext2.amd.com ([163.181.251.1]:32505 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S266286AbUANDkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 22:40:12 -0500
Message-ID: <99F2150714F93F448942F9A9F112634C080EF39F@txexmtae.amd.com>
From: paul.devriendt@amd.com
To: davej@redhat.com
cc: pavel@ucw.cz, cpufreq@www.linux.org.uk, linux@brodo.de,
       linux-kernel@vger.kernel.org, mark.langsdorf@amd.com
Subject: RE: Cleanups for powernow-k8
Date: Tue, 13 Jan 2004 21:39:53 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 6C1A658013169566-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Dave had a good idea of a minimal ACPI parser for trying to retrieve the
>> table of p-states from an ACPI BIOS without needing the full AML interpreter.
>> I will see if I can get that to work in powernow-k8-acpi 
>  
> If done properly, that parsing code could be shared by the K7 
> driver too.
> 
> 	Dave

Agreed. Function in a header file? Don't want the drivers attempting to
call each other at runtime.


 

