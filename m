Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTIDUhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTIDUhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:37:18 -0400
Received: from rudnanet.customer.vol.cz ([195.122.192.2]:53122 "EHLO
	pavel.janik.cz") by vger.kernel.org with ESMTP id S262069AbTIDUhE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:37:04 -0400
To: linux-kernel@vger.kernel.org
Subject: ENE Technology's flash reader
From: Pavel@Janik.cz (=?iso-8859-15?q?Pavel_Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Thu, 04 Sep 2003 22:39:54 +0200
Message-ID: <m3he3s5lut.fsf@Janik.cz>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have access to ASUS Pundit which has 4-in-1 card reader on it. It is
based on ENE CB710 chip (http://www.ene.com.tw/product_cb710.htm):

00:10.1 FLASH memory: ENE Technology Inc: Unknown device 0510
        Subsystem: Asustek Computer, Inc.: Unknown device 1724
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 4
        Region 0: I/O ports at 8800 [size=128]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 24 15 10 05 01 00 10 02 00 00 01 05 08 20 00 00
10: 01 88 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 24 17
30: 00 00 00 00 a0 00 00 00 00 00 00 00 04 02 00 00
40: 00 00 a0 10 00 06 ff 00 1d 08 00 f1 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00
a0: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Is it supported? How could I make it working? I'm ready to provide more
information.

More data about it:

VENDOR_ID: 1524
DEVICE_ID: 0510
COMMAND: 0001
STATUS: 0210
REVISION: 00
CLASS_PROG: 00
CLASS_DEVICE: 0501
CACHE_LINE_SIZE: 08
LATENCY_TIMER: 20
HEADER_TYPE: 00
BIST: 00
BASE_ADDRESS_0: 00008801
BASE_ADDRESS_1: 00000000
BASE_ADDRESS_2: 00000000
BASE_ADDRESS_3: 00000000
BASE_ADDRESS_4: 00000000
BASE_ADDRESS_5: 00000000
CARDBUS_CIS: 00000000
SUBSYSTEM_VENDOR_ID: 17241043
SUBSYSTEM_ID: 1724
ROM_ADDRESS: 00000000
INTERRUPT_LINE: 04
INTERRUPT_PIN: 02
MIN_GNT: 00
MAX_LAT: 00
PRIMARY_BUS: 00
SECONDARY_BUS: 00
SUBORDINATE_BUS: 00
SEC_LATENCY_TIMER: 00
IO_BASE: 00
IO_LIMIT: 00
SEC_STATUS: 0000
MEMORY_BASE: 0000
MEMORY_LIMIT: 0000
PREF_MEMORY_BASE: 0000
PREF_MEMORY_LIMIT: 0000
PREF_BASE_UPPER32: 00000000
PREF_LIMIT_UPPER32: 17241043
IO_BASE_UPPER16: 0000
IO_LIMIT_UPPER16: 0000
BRIDGE_ROM_ADDRESS: 00000000
BRIDGE_CONTROL: 0000
CB_CARDBUS_BASE: 00008801
CB_CAPABILITIES: 0000
CB_SEC_STATUS: 0000
CB_BUS_NUMBER: 00
CB_CARDBUS_NUMBER: 00
CB_SUBORDINATE_BUS: 00
CB_CARDBUS_LATENCY: 00
CB_MEMORY_BASE_0: 00000000
CB_MEMORY_LIMIT_0: 00000000
CB_MEMORY_BASE_1: 00000000
CB_MEMORY_LIMIT_1: 00000000
CB_IO_BASE_0: 1043
CB_IO_BASE_0_HI: 1724
CB_IO_LIMIT_0: 0000
CB_IO_LIMIT_0_HI: 0000
CB_IO_BASE_1: 00a0
CB_IO_BASE_1_HI: 0000 
CB_IO_LIMIT_1: 0000
CB_IO_LIMIT_1_HI: 0000
CB_SUBSYSTEM_VENDOR_ID: 0000
CB_SUBSYSTEM_ID: 10a0
CB_LEGACY_MODE_BASE: 00ff0600
-- 
Pavel Janík

GNU/Do GNU/you GNU/still GNU/insist GNU/on GNU/inserting GNU/ GNU/in
GNU/front GNU/of GNU/everything GNU/you GNU/see?
                  -- Someone on /. to Bradley M. Kuhn
