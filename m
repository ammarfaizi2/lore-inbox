Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWFGNju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWFGNju (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 09:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWFGNju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 09:39:50 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:58989 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932177AbWFGNjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 09:39:49 -0400
Date: Wed, 7 Jun 2006 15:39:47 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: kernel coder <lhrkernelcoder@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RTL explaination
Message-ID: <20060607133947.GA13838@harddisk-recovery.com>
References: <f69849430606070554h5cadb39cgfd5f70f6de09707c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69849430606070554h5cadb39cgfd5f70f6de09707c@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 05:54:43PM +0500, kernel coder wrote:
> I'm trying to understand the rtl genrated by gcc for mips processor.I
> have read gcc internals by Richard Stallman but there  are still some
> confusions in the rtl language.
> 
> Following is a snippet of code which i'm trying to understand.
> 
> (insn 9 6 10 (nil) (set (reg:SI 182)
>        (mem/f:SI (symbol_ref:SI ("a")) [0 a+0 S4 A32])) -1 (nil)
>    (nil))
> 
> In the above code following part is still unclear to me
> 
> [0 a+0 S4 A32])) -1 (nil)
>    (nil))
> 
> Following is the c code for which above rtl is generated :
> 
> int a;
> main()
> {
> a=a+1;
> }

I think you will get many more responses on a mailing list dedicated to
gcc... See http://gcc.gnu.org/lists.html .


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
