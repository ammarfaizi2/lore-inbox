Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbRBTGbO>; Tue, 20 Feb 2001 01:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129668AbRBTGbF>; Tue, 20 Feb 2001 01:31:05 -0500
Received: from [202.212.27.177] ([202.212.27.177]:51977 "HELO antiopikon")
	by vger.kernel.org with SMTP id <S129458AbRBTGav>;
	Tue, 20 Feb 2001 01:30:51 -0500
Date: Tue, 20 Feb 2001 15:30:48 +0900
From: Augustin Vidovic <vido@ldh.org>
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: eepro100.c, kernel 2.4.1
Message-ID: <20010220153048.A26551@ldh.org>
Reply-To: vido@ldh.org
In-Reply-To: <20010212133248.A7147@saw.sw.com.sg> <Pine.LNX.4.30.0102120048160.4687-100000@age.cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0102120048160.4687-100000@age.cs.columbia.edu>; from ionut@cs.columbia.edu on Mon, Feb 12, 2001 at 01:00:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 01:00:34AM -0800, Ion Badulescu wrote:
> > Augustin, could you send the output of `lspci' and `eepro100-diag -ee', please?
> > (The latter may be taken from ftp://scyld.com/pub/diag/)
> 
> I'd be curious to see them too.

Ok, here is the output (the status are displayed only if the interface
is down, so I had to go execute this manually on the machines) :


eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xef00.
i82557 chip registers at 0xef00:
  00000000 00000000 00000000 00080002 182541e1 00000600
  No interrupt sources are pending.
   The transmit unit state is 'Idle'.
   The receive unit state is 'Idle'.
  This status is unusual for an activated interface.
Index #2: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xee80.
i82557 chip registers at 0xee80:
  00000000 00000000 00000000 00080002 183f0000 00000000
  No interrupt sources are pending.
   The transmit unit state is 'Idle'.
   The receive unit state is 'Idle'.
  This status is unusual for an activated interface.
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xef00.
i82557 chip registers at 0xef00:
  00000000 00000000 00000000 00080002 182541e1 00000600
  No interrupt sources are pending.
   The transmit unit state is 'Idle'.
   The receive unit state is 'Idle'.
  This status is unusual for an activated interface.
Index #2: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xee80.
i82557 chip registers at 0xee80:
  00000000 00000000 00000000 00080002 183f0000 00000000
  No interrupt sources are pending.
   The transmit unit state is 'Idle'.
   The receive unit state is 'Idle'.
  This status is unusual for an activated interface.
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xef00.
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address 00:D0:B7:00:BE:00.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
Index #2: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xee80.
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address 00:D0:B7:00:BE:01.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xef00.
EEPROM contents, size 64x16:
    00: d000 00b7 00be 0c03 0003 0201 4701 0000
  0x08: 0000 0000 40a2 3000 8086 0000 0000 0000
      ...
  0x38: 0000 0000 0000 0000 0000 0000 0000 a315
 The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address 00:D0:B7:00:BE:00.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
Index #2: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xee80.
EEPROM contents, size 64x16:
    00: d000 00b7 01be 0c03 0003 0201 4701 0000
  0x08: 0000 0000 40a2 3000 8086 0000 0000 0000
      ...
  0x38: 0000 0000 0000 0000 0000 0000 0000 a215
 The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address 00:D0:B7:00:BE:01.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xef00.
 MII PHY #1 transceiver registers:
  3000 782d 02a8 0154 05e1 41e1 0003 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0203 0000 0001 ffff 0000 0001 ffff 0001
  0004 0000 0000 0000 0000 0000 0000 0000.
Index #2: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xee80.
 MII PHY #1 transceiver registers:
  3000 7809 02a8 0154 05e1 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0001 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000.
