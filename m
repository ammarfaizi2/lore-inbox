Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263947AbRFEJdl>; Tue, 5 Jun 2001 05:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263943AbRFEJda>; Tue, 5 Jun 2001 05:33:30 -0400
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:58821
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S263948AbRFEJdV>; Tue, 5 Jun 2001 05:33:21 -0400
Date: Tue, 5 Jun 2001 11:33:19 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@mars.fachschaften.tu-muenchen.de>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures
In-Reply-To: <15132.23395.553496.50934@argo.ozlabs.ibm.com>
Message-ID: <Pine.NEB.4.33.0106051124320.18917-100000@mars.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001, Paul Mackerras wrote:

>...
> This is why I added #ifdef __KERNEL__ around most of the contents
> of include/asm-ppc/*.h.  It was done deliberately to flush out those
> programs which are depending on kernel headers when they shouldn't.

Whatever the right policy is, the main concern in my initial mail was the
_consistency_ of the kernel headers between different architectures.
So when you want to flush out these programs I see no reason to
inconsistetly change it only on one architecture.


> Paul.

cu
Adrian

-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi


