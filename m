Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUCLBmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUCLBmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:42:42 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:38572 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261786AbUCLBml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:42:41 -0500
Message-ID: <40511590.9070006@blueyonder.co.uk>
Date: Fri, 12 Mar 2004 01:42:40 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-mm1 entry.S errors x86_64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2004 01:42:40.0320 (UTC) FILETIME=[4E1C7C00:01C407D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building x86_64 gives the following error:-
  AS      arch/x86_64/kernel/entry.o
arch/x86_64/kernel/entry.S: Assembler messages:
arch/x86_64/kernel/entry.S:873: Error: CFI instruction used without 
previous .cfi_startproc
arch/x86_64/kernel/entry.S:873: Warning: rest of line ignored; first 
ignored character is `9'
arch/x86_64/kernel/entry.S:873: Error: CFI instruction used without 
previous .cfi_startproc
arch/x86_64/kernel/entry.S:873: Error: no such instruction: 
`rdi,8*8-(9*8+0)'
arch/x86_64/kernel/entry.S:873: Error: CFI instruction used without 
previous .cfi_startproc
arch/x86_64/kernel/entry.S:873: Error: no such instruction: 
`rsi,7*8-(9*8+0)'
arch/x86_64/kernel/entry.S:873: Error: CFI instruction used without 
previous .cfi_startproc
arch/x86_64/kernel/entry.S:873: Error: no such instruction: 
`rdx,6*8-(9*8+0)'
arch/x86_64/kernel/entry.S:873: Error: CFI instruction used without 
previous .cfi_startproc
arch/x86_64/kernel/entry.S:873: Error: no such instruction: 
`rcx,5*8-(9*8+0)'
arch/x86_64/kernel/entry.S:873: Error: CFI instruction used without 
previous .cfi_startproc
arch/x86_64/kernel/entry.S:873: Error: no such instruction: 
`rax,4*8-(9*8+0)'
arch/x86_64/kernel/entry.S:873: Error: CFI instruction used without 
previous .cfi_startproc
arch/x86_64/kernel/entry.S:873: Error: no such instruction: `r8,3*8-(9*8+0)'
arch/x86_64/kernel/entry.S:873: Error: CFI instruction used without 
previous .cfi_startproc
etc.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

