Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTIIU6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTIIU6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:58:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25873 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264382AbTIIU6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:58:01 -0400
Date: Tue, 9 Sep 2003 21:57:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable data
Message-ID: <20030909215758.Q4216@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030909204803.N4216@flint.arm.linux.org.uk> <20030909201436.GA1382@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030909201436.GA1382@redhat.com>; from davej@redhat.com on Tue, Sep 09, 2003 at 09:14:37PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 09:14:37PM +0100, Dave Jones wrote:
> On Tue, Sep 09, 2003 at 08:48:03PM +0100, Russell King wrote:
>  > -static struct pci_device_id agp_ati_pci_table[] __initdata = {
>  > +static struct pci_device_id agp_ati_pci_table[] = {
> 
> Wierd. I could swear akpm had these patches in his tree no so long back.

So did I, so I checked the history in bk, and it seems it never made Linus'
tree.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
