Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275098AbRIYQtO>; Tue, 25 Sep 2001 12:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275104AbRIYQtF>; Tue, 25 Sep 2001 12:49:05 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:37380 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S275098AbRIYQsv>; Tue, 25 Sep 2001 12:48:51 -0400
Date: Tue, 25 Sep 2001 18:49:14 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <laughing@shared-source.org>
Subject: Re: Linux 2.4.9-ac15
Message-ID: <20010925184914.B27294@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <laughing@shared-source.org>
In-Reply-To: <20010924164143.A11157@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010924164143.A11157@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Alan Cox wrote:

> 2.4.9-ac15

Among others, I get these when building modules:

/kernel/l249-ac15/include/linux/smp.h:80: warning: `smp_num_cpus' redefined
/kernel/l249-ac15/include/linux/modules/i386_ksyms.ver:84: warning: this is the location of the previous definition
/kernel/l249-ac15/include/linux/smp.h:87: warning: `smp_call_function' redefined
/kernel/l249-ac15/include/linux/modules/i386_ksyms.ver:100: warning: this is the location of the previous definition
/kernel/l249-ac15/include/linux/smp.h:88: warning: `cpu_online_map' redefined
/kernel/l249-ac15/include/linux/modules/i386_ksyms.ver:86: warning: this is the location of the previous definition
msr.c: In function `msr_open':
msr.c:230: `cpu_data' undeclared (first use in this function)
msr.c:230: (Each undeclared identifier is reported only once
msr.c:230: for each function it appears in.)
make[1]: *** [msr.o] Error 1
make[1]: Leaving directory `/kernel/l249-ac15/arch/i386/kernel'
