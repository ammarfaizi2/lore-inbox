Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270555AbUJTUNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270555AbUJTUNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270508AbUJTUI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:08:57 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:1355 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270494AbUJTUI2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:08:28 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rDz2BkyyC6I7LB3xYhCZbjHgsoQfPo1zWiRQg6bKGsjWo7U6Pfjxa8g8Ajxi0D9Wcjs7SvKhs3wkEMSwgoEdoVFwwSNKE6uFHiDBGU+ZKjVh/eWbNRE9RR8mVl+DwyMovV0nBZws3DMAb3tlPrOTmQbC4y1kGEj6vIeL4YVFDYI
Message-ID: <7aaed091041020130823ce1665@mail.gmail.com>
Date: Wed, 20 Oct 2004 22:08:25 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
Reply-To: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.9-rc4-mm1 amd64 Computer crashes on "Freeing unused kernel memory: 200k"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041020145532.GA9689@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <2QMVB-2nB-13@gated-at.bofh.it>
	 <m3wtxn67h2.fsf@averell.firstfloor.org>
	 <7aaed09104101908174a9e430a@mail.gmail.com>
	 <7aaed09104101914093ff72736@mail.gmail.com>
	 <20041020145532.GA9689@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Oct 2004 16:55:32 +0200, Andi Kleen <ak@muc.de> wrote:
> On Tue, Oct 19, 2004 at 11:09:10PM +0200, Espen Fjellv?r Olsen wrote:
> > I'm sending my dmesg and lspci output, and my .config files.
> 
> Does it work with "noapic" or "nolapic" or "acpi=off" or
> "noapic acpi_irq_balance" ?
> 
> -Andi
> 
It looks like it was a problem with Lilo or something. I managed to
install grub, and then the error went straigth away.
A bit weird tho.

-- 
Mvh / Best regards
Espen Fjellvær Olsen
espenfjo@gmail.com
Norway
