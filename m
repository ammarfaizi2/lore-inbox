Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbTCTWQs>; Thu, 20 Mar 2003 17:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbTCTWQr>; Thu, 20 Mar 2003 17:16:47 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:7121 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S262658AbTCTWQq>;
	Thu, 20 Mar 2003 17:16:46 -0500
Date: Thu, 20 Mar 2003 23:27:44 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: James Wright <james@jigsawdezign.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, jun.nakajima@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: P4 3.06Ghz Hyperthreading with 2.4.20?
Message-ID: <20030320222744.GA1975@werewolf.able.es>
References: <F760B14C9561B941B89469F59BA3A847E96D2E@orsmsx401.jf.intel.com> <20030320212934.0e4ad939.james@jigsawdezign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030320212934.0e4ad939.james@jigsawdezign.com>; from james@jigsawdezign.com on Thu, Mar 20, 2003 at 22:29:34 +0100
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.20, James Wright wrote:
> 
>   I have patched my 2.4.20 kernel with the relevant ACPI patch, and now it suing ACPI
> it detects the 2 Logical CPU's BUT it still disables SMP and /proc/cpuinfo only shows one processor... Sorry for the including this but here is a extract "dmesg":
> 
[...]
> SMP motherboard not detected.

Check if your bios has something like 'Enable ACPI register'. My 400GX has it.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre5-jam0 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
