Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVANV7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVANV7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVANV7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:59:04 -0500
Received: from mproxy.gmail.com ([216.239.56.245]:7325 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262186AbVANV5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:57:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VK4MuSOrogXKKY5cfrfMjklhpgWZwaVB15V+tWfW9QM7i/QuDKkES2Qza2Edcu8t6uRtGwDoAomvcXr7ppzhXOvQ7g/IJodp/ViU+RCSh1trMa2OSe4xNQsHIPQF8W1sFVfjqjCElISVDlcivzVdJl5TyDg4tTnvwqYaTriwBTE=
Message-ID: <7f45d939050114135752a00033@mail.gmail.com>
Date: Fri, 14 Jan 2005 13:57:39 -0800
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Poor responsiveness during disk I/O
In-Reply-To: <1105732650.6042.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <7f45d9390501141121269b42b2@mail.gmail.com>
	 <1105732650.6042.50.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you report a problem to the kernel mailing list suggesting the kernel
> does something suboptimal, but you entirely forgot to mention which
> kernel you are using ;) Could you fix that ommision please?

Sorry, not my best moment.

Linux 2.6.8.1

Here's /proc/interrupts and /proc/dma in addition to the previous
information I posted.

Cheers,
Shaun

$ cat /proc/version
Linux version 2.6.8.1 (sjackman@quince) (gcc version 3.3.4 (Debian
1:3.3.4-6sarge1)) #1 Mon Oct 4 13:42:45 PDT 2004
$ cat /proc/interrupts
           CPU0
  0:  498236341          XT-PIC  timer
  7:     791002    IO-APIC-edge  parport0
  8:  111803954    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:    4663149    IO-APIC-edge  ide0
 15:   25527687    IO-APIC-edge  ide1
 16:    1581279   IO-APIC-level  ivtv0
 18:    3558673   IO-APIC-level  eth0
 21:    3687135   IO-APIC-level  ohci_hcd, ohci_hcd, NVidia nForce
NMI:          0
LOC:  498270903
ERR:          0
MIS:          4
$ cat /proc/dma
 4: cascade
