Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135571AbRD3QjB>; Mon, 30 Apr 2001 12:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135576AbRD3Qiv>; Mon, 30 Apr 2001 12:38:51 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7650 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S135571AbRD3Qip>;
	Mon, 30 Apr 2001 12:38:45 -0400
Message-ID: <3AED950C.962360AF@mandrakesoft.com>
Date: Mon, 30 Apr 2001 12:38:36 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Greg Hosler <hosler@lugs.org.sg>, linux-kernel@vger.kernel.org
Subject: Re: AC'97 (VT82C686A) & IRQ reassignment (I/O APIC)
In-Reply-To: <Pine.LNX.3.95.1010430113545.13070A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> Observe that the PCI DWORD (long) register at DWORD offset 15 consists
> of 4 byte-wide registers (from the PCI specification), Max_lat, Min_Gnt,
> Interrupt pin, and interrupt line.  Nothing has to fit into 4 bits, you
> have 8 bits. I haven't looked at the Linux code, but if it provides only 4
> bits for the IRQ, it's broken.

Non-IO-APIC Via audio hardware only decodes the lower 4 bits of the IRQ.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
