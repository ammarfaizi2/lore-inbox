Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSECAoN>; Thu, 2 May 2002 20:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315511AbSECAoM>; Thu, 2 May 2002 20:44:12 -0400
Received: from ns.suse.de ([213.95.15.193]:29201 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315491AbSECAoM>;
	Thu, 2 May 2002 20:44:12 -0400
Date: Fri, 3 May 2002 02:44:09 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ekuznetsov@divxnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: Re[4]: Support of AMD 762?
Message-ID: <20020503024409.B23381@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, ekuznetsov@divxnetworks.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <46328234.20020502145748@divxnetworks.com> <E173R3Y-0005GN-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 01:36:16AM +0100, Alan Cox wrote:
 > > ENABLING IO-APIC IRQs
 > > Setting 2 in the phys_id_present_map
 > > ...changing IO-APIC physical APIC ID to 2 ... ok.
 > 
 > You are using APIC mode - the $PIR router isnt even involved. The AMD 762
 > BIOS and Software writers guide discusses the MP mode behaviour if you want
 > to look into it further but it looks as if your BIOS is simply horked

Note the dmesg output mentioned XP's. Either the BIOS is dumb and hasn't
programmed the namestring properly, or theres a possibility it may be in
"This isnt a valid SMP setup" mode, and thus not setting up MP table (correctly)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
