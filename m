Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283268AbSACIdu>; Thu, 3 Jan 2002 03:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284019AbSACIdk>; Thu, 3 Jan 2002 03:33:40 -0500
Received: from t2.redhat.com ([199.183.24.243]:31990 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S283268AbSACId2>;
	Thu, 3 Jan 2002 03:33:28 -0500
Date: Thu, 3 Jan 2002 00:32:40 -0800
From: Richard Henderson <rth@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Tom Rini <trini@kernel.crashing.org>, jtv <jtv@xs4all.nl>,
        Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103003240.A10838@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Tom Rini <trini@kernel.crashing.org>, jtv <jtv@xs4all.nl>,
	Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
	gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
	Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Corey Minyard <minyard@acm.org>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102232320.A19933@xs4all.nl> <20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103004514.B19933@xs4all.nl> <20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102160739.A10659@redhat.com> <15411.49911.958835.299377@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15411.49911.958835.299377@argo.ozlabs.ibm.com>; from paulus@samba.org on Thu, Jan 03, 2002 at 01:33:27PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 01:33:27PM +1100, Paul Mackerras wrote:
> I look forward to seeing your patch to remove all uses of
> virt_to_phys, phys_to_virt, __pa, __va, etc. from arch/alpha... :)

I don't dereference them either, do I?


r~
