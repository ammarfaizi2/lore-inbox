Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135819AbRECRlw>; Thu, 3 May 2001 13:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135823AbRECRlm>; Thu, 3 May 2001 13:41:42 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:18445 "HELO
	zcamail04.zca.compaq.com") by vger.kernel.org with SMTP
	id <S135819AbRECRla>; Thu, 3 May 2001 13:41:30 -0400
Message-ID: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDD2@aeoexc1.aeo.cpqcorp.net>
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: "Rival, Frank" <FRIVAL@ZK3.DEC.COM>, Andrea Arcangeli <andrea@suse.de>
Cc: "'Andrew Morton'" <andrewm@uow.edu.au>,
        "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>
Subject: RE: [BUG] freeze Alpha ES40 SMP 2.4.4.ac3, another TCP/IP Problem
	 ? (  was 2.4.4 kernel crash , possibly tcp related )
Date: Thu, 3 May 2001 19:41:13 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Silly question, Sebastien - when you do a "show config" at the console, how
>is your card represented?  FWIU, there have been problems with adapters
under
>load that aren't fully supported by SRM...  Just a guess.  Could you try
this
>with a DE600 (Intel) or a DE500 (tulip)?

> - Pete



appended to this email is the output of show conf

I can see the 3COM board at first slot 2
I also have a DE600 board into slot 6 of second PCI bus

DE600 boards freeze my system 
DE504 board freeze my system

I have tried to change the switch, point to point connections... So I
changed to 3com905b
to have a more standart board (in the linux community I mean). :(((



P00>>>show conf
                        Compaq Computer Corporation
                          Compaq AlphaServer ES40

Firmware
SRM Console:    V5.9-24
ARC Console:    v5.70
PALcode:        OpenVMS PALcode V1.90-101, Tru64 UNIX PALcode V1.86-101
Serial ROM:     V2.12-F  
RMC ROM:        V1.0
RMC Flash ROM:  V2.6

Processors
CPU 0           Alpha EV68A pass 2.1 or 2.1A or 3.0 833 MHz  8MB Bcache
CPU 1           Alpha EV68A pass 2.1 or 2.1A or 3.0 833 MHz  8MB Bcache
CPU 2           Alpha EV68A pass 2.1 or 2.1A or 3.0 833 MHz  8MB Bcache
CPU 3           Alpha EV68A pass 2.1 or 2.1A or 3.0 833 MHz  8MB Bcache

Core Logic
Cchip           DECchip 21272-CA Rev 9(C4)
Dchip           DECchip 21272-DA Rev 2
Pchip 0         DECchip 21272-EA Rev 2
Pchip 1         DECchip 21272-EA Rev 2
TIG             Rev 10

Memory
  Array       Size       Base Address    Intlv Mode
---------  ----------  ----------------  ----------
    0       2048Mb     0000000000000000    4-Way
    1       2048Mb     0000000080000000    4-Way
    2       2048Mb     0000000100000000    4-Way
    3       2048Mb     0000000180000000    4-Way

     8192 MB of System Memory

 Slot   Option                  Hose 0, Bus 0, PCI
   1    NCR 53C895              pkb0.7.0.1.0            SCSI Bus ID 7
                                dkb0.0.0.1.0            COMPAQ BD009635C3
                                dkb100.1.0.1.0          COMPAQ BF01863644
                                dkb200.2.0.1.0          COMPAQ BF01863644
   2    905510B7/905510B7                           
   3    804314C1/804314C1                           
   7    Acer Labs M1543C                                Bridge to Bus 1, ISA
  15    Acer Labs M1543C IDE    dqa.0.0.15.0        
                                dqb.0.1.15.0        
                                dqa0.0.0.15.0           Compaq   CRD-8402B
  19    Acer Labs M1543C USB                        

        Option                  Hose 0, Bus 1, ISA
        Floppy                  dva0.0.0.1000.0     

 Slot   Option                  Hose 1, Bus 0, PCI
   4    NCR 53C895              pka0.7.0.4.1            SCSI Bus ID 7
                                dka0.0.0.4.1            COMPAQ BF01863644
                                dka100.1.0.4.1          COMPAQ BF01863644
                                dka200.2.0.4.1          COMPAQ BF01863644
                                dka300.3.0.4.1          COMPAQ BF01863644
   5    QLogic QLA2200          pya0.0.0.5.1        
   6    DE600-AA                eia0.0.0.6.1            00-50-8B-AE-DD-A0
