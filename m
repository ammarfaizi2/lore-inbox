Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312505AbSD2PRI>; Mon, 29 Apr 2002 11:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312524AbSD2PRH>; Mon, 29 Apr 2002 11:17:07 -0400
Received: from fmr02.intel.com ([192.55.52.25]:24803 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S312505AbSD2PRH>; Mon, 29 Apr 2002 11:17:07 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7DE9@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Witek Krecicki'" <adasi@kernel.pl>, linux-kernel@vger.kernel.org
Subject: RE: [BUG]: ACPI oopsing at boottime 
Date: Mon, 29 Apr 2002 08:15:30 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Witek Krecicki [mailto:adasi@kernel.pl] 
> It's making oops and panic at boot time. Full ksymoops output:
> >>EIP; c017431f <acpi_ex_read_data_from_field+4f/150>   <=====
> Trace; c017798c <acpi_ex_resolve_node_to_value+bc/1b0>
> Trace; c0177ac1 <acpi_ex_resolve_to_value+41/50>
> Trace; c0177edd <acpi_ex_resolve_operands+1bd/340>
> Trace; c016fab9 <acpi_ds_eval_region_operands+39/a0>
> Trace; c0170612 <acpi_ds_exec_end_op+242/2d0>
> Trace; c017ce41 <acpi_ps_parse_loop+5a1/970>
> Trace; c01832f7 <acpi_ut_create_generic_state+7/20>

Can you duplicate with latest ACPI patch from sf.net/projects/acpi?

Thanks -- Regards -- Andy
