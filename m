Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315519AbSECBMK>; Thu, 2 May 2002 21:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315520AbSECBMJ>; Thu, 2 May 2002 21:12:09 -0400
Received: from sandiego.divxnetworks.com ([207.67.92.110]:53940 "HELO
	trinity.divxnetworks.com") by vger.kernel.org with SMTP
	id <S315519AbSECBMI>; Thu, 2 May 2002 21:12:08 -0400
Date: Thu, 2 May 2002 18:11:22 -0700
From: Eugene Kuznetsov <ekuznetsov@divxnetworks.com>
X-Mailer: The Bat! (v1.53d) Personal
Reply-To: Eugene Kuznetsov <ekuznetsov@divxnetworks.com>
Organization: PM
X-Priority: 3 (Normal)
Message-ID: <105494937.20020502181122@divxnetworks.com>
To: Dave Jones <davej@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re[6]: Support of AMD 762?
In-Reply-To: <20020503024409.B23381@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

Thursday, May 02, 2002, 5:44:09 PM, you wrote:

DJ> On Fri, May 03, 2002 at 01:36:16AM +0100, Alan Cox wrote:
DJ>  > > ENABLING IO-APIC IRQs
DJ>  > > Setting 2 in the phys_id_present_map
DJ>  > > ...changing IO-APIC physical APIC ID to 2 ... ok.
DJ>  > 
DJ>  > You are using APIC mode - the $PIR router isnt even involved. The AMD 762
DJ>  > BIOS and Software writers guide discusses the MP mode behaviour if you want
DJ>  > to look into it further but it looks as if your BIOS is simply horked

DJ> Note the dmesg output mentioned XP's. Either the BIOS is dumb and hasn't
DJ> programmed the namestring properly, or theres a possibility it may be in
DJ> "This isnt a valid SMP setup" mode, and thus not setting up MP table (correctly)

They are MPs. BIOS correctly determines them during bootup
( before LILO ).

-- 
Best regards,
 Eugene                            mailto:ekuznetsov@divxnetworks.com

