Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132608AbRALETx>; Thu, 11 Jan 2001 23:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133020AbRALETn>; Thu, 11 Jan 2001 23:19:43 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:45823 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S132608AbRALET2>;
	Thu, 11 Jan 2001 23:19:28 -0500
Message-ID: <3A5E85CC.40606@voicefx.com>
Date: Thu, 11 Jan 2001 23:19:24 -0500
From: "John O'Donnell" <johnod@voicefx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IDE DMA problems on 2.4.0 with vt82c686a driver
In-Reply-To: <E14Gj32-0002ND-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>> us who have via chipset motherboards, suggesting that it is limited 
>> to that chipset, that chipset is ubiquitous, or via chipset 
>> motherboard owners are generally the complaining type. no idea which 
>> applies there, either.
> 
> 
> Or there are a lot of them. 90% of scsi bug reports I get are adaptec 29xx
> driver. Thats not because the adaptec 29xx is the most sucky driver 8)
> 
> Firstly there are numerous reasons for CRC errors. At ATA100 even the track
> length and the capacitance of the connectors becomes an issue. It is quite
> possibly a driver issue. It could even be that specific combination of drives
> and ide controller is right on the edge of the spec limits and just slightly
> dipping over. It might be the odd power spike.
> 
> Providing the code is working sanely the odd CRC error shouldnt be a 
> problem and should be causing a command retry. The CRC checking used in ATA
> is very robust so unlike scsi parity errors which couldnt be ignored ATA
> ones on occassion are probably fine
> 
> ATA100 is another testimony to the fact that pigs can be made to fly given 
> sufficient thrust (to borrow an RFC)
> 
> Alan

I acquired a VIA Mobo (ASUS CUV4X) for home and it is workin pretty damn
spiffy with Linux - Even better with 2.4.0 with regards to IDE!!!
Once a month I boot WinDOS to play a game I can't play in Linux, THEN
my troubles begin!!!
parport_pc: Via 686A parallel port: io=0x378, irq=7, dma=3
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:4.1
etc... etc... etc...
yadda yadda yadda ....

Alan,
My father repaired F-4 Phantoms in Vietnam.  He said the F-4 Phantom was
proof that if you put enough power behind a brick, it would fly!!!
Your comment remonded me of that - just had to share  :-)

-- 
<SomeLamer> what's the difference between chattr and chmod?
<SomeGuru> SomeLamer: man chattr > 1; man chmod > 2; diff -u 1 2 | less
	-- Seen on #linux on irc
=== Never ask a geek why, just nod your head and slowly back away.===
+==============================+====================================+
| John O'Donnell (Sr. Systems Engineer, Net Admin, Webmaster, etc.) |
| Voice FX Corporation (a subsidiary of Student Advantage)          |
| One Plymouth Meeting         |     E-Mail: johnod@voicefx.com     |
| Suite 610                    |           www.voicefx.com          |
| Plymouth Meeting, PA 19462   |         www.campusdirect.com       |
+==============================+====================================+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
