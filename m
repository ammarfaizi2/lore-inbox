Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261816AbTCGWCS>; Fri, 7 Mar 2003 17:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbTCGWCS>; Fri, 7 Mar 2003 17:02:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32175
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261816AbTCGWCR>; Fri, 7 Mar 2003 17:02:17 -0500
Subject: Re: [RFC] one line fix in arch/i386/Kconfig
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030307220337.5841.qmail@linuxmail.org>
References: <20030307220337.5841.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047079121.23696.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 23:18:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 22:03, Paolo Ciarrocchi wrote:
> If I say that my cpu is not a PentiumIV why
> he bothers me about "check for P4 thermal throttling interrupt." ?
> 
> This patch show that option only if you select that kind of CPU.
> 
> Is it correct ? Does it makes sense ?

We want people to be able to build a kernel which will run on many systems
but still use CPU specific features. 

