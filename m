Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSJ2Pg3>; Tue, 29 Oct 2002 10:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261945AbSJ2Pg2>; Tue, 29 Oct 2002 10:36:28 -0500
Received: from kim.it.uu.se ([130.238.12.178]:33223 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261914AbSJ2Pg1>;
	Tue, 29 Oct 2002 10:36:27 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15806.44149.472622.392381@kim.it.uu.se>
Date: Tue, 29 Oct 2002 16:42:45 +0100
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to diagnose...
In-Reply-To: <20021029152723.GR3420@rdlg.net>
References: <20021029152723.GR3420@rdlg.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris writes:
 > was scrolling so fast I couldn't even read it.  It looked like it was 
 > reporting ACIC errors on a CPU but couldn't quite be sure.  It required 
 > a hard reset as it was unresponsive to c-a-d and sysreq commands.

If it says "APIC error on CPU blah" then you have a problem.
First, upgrade to something a bit more trustworthy, like 2.4.20-pre11
or RedHat's 2.4.18-17.7.x kernel. If that doesn't help, try booting
with "noapic" as parameter to the kernel.

/Mikael
