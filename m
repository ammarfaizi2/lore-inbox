Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129079AbQKMSfB>; Mon, 13 Nov 2000 13:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129439AbQKMSev>; Mon, 13 Nov 2000 13:34:51 -0500
Received: from chiara.elte.hu ([157.181.150.200]:13582 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129079AbQKMSef>;
	Mon, 13 Nov 2000 13:34:35 -0500
Date: Fri, 10 Nov 2000 15:29:03 +0100
From: KELEMEN Peter <fuji@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [sparc32] 2.4.0-test11-pre2 does not boot
Reply-To: fuji@elte.hu
Mail-Followup-To: fuji@elte.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Mail-Copies-To: fuji@elte.hu
Organization: ELTE Eotvos Lorand University of Sciences, Budapest, Hungary
X-GPG-KeyID: 1024D/EE4C26E8 2000-03-20
X-GPG-Fingerprint: D402 4AF3 7488 165B CC34  4147 7F0C D922 EE4C 26E8
X-PGP-KeyID: 1024/45F83E45 1998/04/04
X-PGP-Fingerprint: 26 87 63 4B 07 28 1F AD  6D AA B5 8A D6 03 0F BF
X-Comment: Personal opinion.  Paragraphs might have been reformatted.
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Accept-Language: hu,en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <20001113183457Z129439-1451+381@vger.kernel.org>

Hello there.

I keep trying to breath life to an old SPARCstation 10 here, no
luck yet.  2.4.0-test11-pre2 compiles without problems, but it
hangs at booting.  Here's what the screen reads:

SILO boot: l240t11p2
PROMLIB: obio_ranges 5
bootmem_init: Scan sp_banks,  init_bootmem(spfn[1d6],bpfn[1d6],mlpfn[c000])
free_bootmem: base[0] size[1000000]
free_bootmem: base[4000000] size[1000000]
free_bootmem: base[8000000] size[1000000]
reserve_bootmem: base[0] size[1d6000]
reserve_bootmem: base[1d6000] size[1800]
Booting Linux...
				   <-- here the screen flashes, and after
				       couple of seconds some kind of a
				       timeout occurs
Watchdog
Type  help  for more information
ok

...and now I'm back at the PROM prompt.

Anyone caring to help?

TIA,
Peter

PS: SuperSPARC-II processor and 64M memory, if that matters.

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Kelemen Péter     /       \       /       \       /      fuji@elte.hu
.+'         `+...+'         `+...+'         `+...+'         `+...+'


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
