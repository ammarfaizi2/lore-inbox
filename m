Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271136AbTGPVrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271143AbTGPVrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:47:40 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:32786
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271136AbTGPVrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:47:36 -0400
Date: Wed, 16 Jul 2003 15:02:36 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm1
Message-ID: <20030716220235.GC1821@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030715225608.0d3bff77.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715225608.0d3bff77.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

I'm having some trouble compiling -mm1

It looks like it's from the ACPI update.

More info available upon request.

gcc version 2.95.4 20011002 (Debian prerelease)

In file included from arch/i386/mach-generic/probe.c:15:
include/asm/genapic.h:30: parse error before bitmap'
include/asm/genapic.h:30: warning: function declaration isn't a prototype
include/asm/genapic.h:34: parse error before physid_mask_t'
include/asm/genapic.h:34: warning: no semicolon at end of struct or union
include/asm/genapic.h:41: parse error before *'
include/asm/genapic.h:41: warning: type defaults to int' in declaration of
physid_mask_t'
include/asm/genapic.h:41: physid_mask_t' declared as function returning a
function
include/asm/genapic.h:41: warning: function declaration isn't a prototype
include/asm/genapic.h:41: warning: data definition has no type or storage
class
include/asm/genapic.h:69: parse error before }'
arch/i386/mach-generic/probe.c: In function generic_apic_probe':
arch/i386/mach-generic/probe.c:44: dereferencing pointer to incomplete type
arch/i386/mach-generic/probe.c:54: dereferencing pointer to incomplete type
arch/i386/mach-generic/probe.c:63: dereferencing pointer to incomplete type
arch/i386/mach-generic/probe.c: At top level:
arch/i386/mach-generic/probe.c:69: mps_oem_check' redeclared as different
kind of symbol
include/asm/genapic.h:58: previous declaration of mps_oem_check'
arch/i386/mach-generic/probe.c: In function mps_oem_check':
arch/i386/mach-generic/probe.c:72: dereferencing pointer to incomplete type
arch/i386/mach-generic/probe.c:75: dereferencing pointer to incomplete type
arch/i386/mach-generic/probe.c: At top level:
arch/i386/mach-generic/probe.c:83: acpi_madt_oem_check' redeclared as
different kind of symbol
include/asm/genapic.h:59: previous declaration of acpi_madt_oem_check'
arch/i386/mach-generic/probe.c: In function acpi_madt_oem_check':
arch/i386/mach-generic/probe.c:86: dereferencing pointer to incomplete type
arch/i386/mach-generic/probe.c:89: dereferencing pointer to incomplete type
arch/i386/mach-generic/probe.c: In function hard_smp_processor_id':
arch/i386/mach-generic/probe.c:98: dereferencing pointer to incomplete type
arch/i386/mach-generic/probe.c:99: warning: control reaches end of non-void
function
{standard input}: Assembler messages:
{standard input}:322: Error: symbol mps_oem_check' is already defined
{standard input}:328: Error: symbol acpi_madt_oem_check' is already defined
make[2]: *** [arch/i386/mach-generic/probe.o] Error 1
make[1]: *** [arch/i386/mach-generic] Error 2
make[1]: *** Waiting for unfinished jobs....
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/do_mounts.o
  CC      init/do_mounts_md.o
	
