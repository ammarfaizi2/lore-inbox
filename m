Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130414AbQKAVyx>; Wed, 1 Nov 2000 16:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131651AbQKAVyn>; Wed, 1 Nov 2000 16:54:43 -0500
Received: from usuario1-37-133-99.dialup.uni2.es ([62.37.133.99]:11012 "HELO
	menzoberrazan.net.dhis.org") by vger.kernel.org with SMTP
	id <S130414AbQKAVya>; Wed, 1 Nov 2000 16:54:30 -0500
Date: Tue, 31 Oct 2000 01:03:31 +0100
From: drizzt.dourden@iname.com
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: linux-kernel@vger.kernel.org, saw@saw.sw.com.sg
Subject: Re: eepro100: card reports no resources [was VM-global...]
Message-ID: <20001031010331.A32094@menzoberrazan>
In-Reply-To: <20001026193508.A19131@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0i
In-Reply-To: <20001026193508.A19131@niksula.cs.hut.fi>; from vherva@mail.niksula.cs.hut.fi on Thu, Oct 26, 2000 at 07:35:08PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Decía Ville Herva:
> Markus Pfeiffer <profmakx@profmakx.de> wrote:
> > 
> > > Oct 26 11:24:13 ns29 kernel: eth0: card reports no resources.
> > > Oct 26 11:24:15 ns29 kernel: eth0: card reports no resources.
> > > Oct 26 12:22:21 ns29 kernel: eth0: card reports no resources.
> > > Oct 26 16:16:59 ns29 kernel: eth0: card reports no resources.
> > > Oct 26 16:28:37 ns29 kernel: eth0: card reports no resources.
> > > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.

I have this problem with the integrated card in a i810E chipset. I cured
reserving the last mega of RAM of the machine ( I have see this in the Redhat
tips for 6.2). 

append="mem=sizeof(mem)-1"

I don't why this work.

Saludos
Drizzt
-- 
... El dinero no da la felicidad, pero la imita perfectamente.
____________________________________________________________________________
Drizzt Do'Urden                Three rings for the Elves Kings under the Sky   
drizzt.dourden@iname.com       Seven for the Dwarf_lords in their  
                               hall of stone
                               Nine for the Mortal Men doomed to die 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
