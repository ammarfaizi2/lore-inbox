Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBFPJn>; Tue, 6 Feb 2001 10:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbRBFPJc>; Tue, 6 Feb 2001 10:09:32 -0500
Received: from 63-216-224-189.sdsl.cais.net ([63.216.224.189]:25298 "HELO
	io.88.net") by vger.kernel.org with SMTP id <S129172AbRBFPJT>;
	Tue, 6 Feb 2001 10:09:19 -0500
Date: Tue, 6 Feb 2001 15:09:18 +0000 (GMT)
From: thomas lakofski <thomas@88.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.x won't boot on my sparcserver 10
Message-ID: <Pine.LNX.4.31.0102051900420.2869-101000@io.88.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1842430495-1816538141-981472158=:18088"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1842430495-1816538141-981472158=:18088
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

I've just set up a small recycled sparcserver 10 as a home firewall.  2.2.18
works fine, but when I tried to install 2.4.[01] I didn't get very far at all
in booting the kernel:

Boot device: /iommu/sbus/espdma@f,400000/esp@f,800000/sd@3,0  File and args:
SILO boot: test
Uncompressing image...
PROMLIB: obio_ranges 5
bootmem_init: Scan sp_banks,  init_bootmem(spfn[19f],bpfn[19f],mlpfn[c000])
free_bootmem: base[0] size[5000000]
free_bootmem: base[8000000] size[4000000]
reserve_bootmem: base[0] size[19f000]
reserve_bootmem: base[19f000] size[1800]
Booting Linux...

Watchdog Reset
Type  help  for more information
ok


I've attached the output of 'ver_linux', dmesg from 2.2.18, my 2.4.1 .config
and the contents of /proc/cpuinfo in 2.2.18.  The box is running debian woody
(unstable).

I noticed that this problem was reported in November or so during the 2.4
prepatches, and the problem report remains in the old (defunct?) 2.4 TODO list
at linux24.sourceforge.net.

If any more information is required I'm very willing to help provide it.

cheers,

Thomas


-- 
          who's watching your watchmen?
gpg: pub 1024D/81FD4B43 sub 4096g/BB6D2B11=>p.nu/d
2B72 53DB 8104 2041 BDB4  F053 4AE5 01DF 81FD 4B43


--1842430495-1816538141-981472158=:18088
Content-Type: APPLICATION/octet-stream; name="ss10bootproblem.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.31.0102061509180.18088@io.88.net>
Content-Description: 
Content-Disposition: attachment; filename="ss10bootproblem.tar.gz"

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
/0fwb4XthDIAUAAA
--1842430495-1816538141-981472158=:18088--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
