Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSHOHeY>; Thu, 15 Aug 2002 03:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSHOHeY>; Thu, 15 Aug 2002 03:34:24 -0400
Received: from elin.scali.no ([62.70.89.10]:33807 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S315472AbSHOHeX>;
	Thu, 15 Aug 2002 03:34:23 -0400
Date: Thu, 15 Aug 2002 09:38:10 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-home.isdn.scali.no
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Fixup pci_alloc_consistent with 64bit DMA masks on i386
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DD92@orsmsx119.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0208150923320.9036-200000@sp-home.isdn.scali.no>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463795199-2053448221-1029396506=:9036"
Content-ID: <Pine.LNX.4.44.0208150930050.9036@sp-home.isdn.scali.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463795199-2053448221-1029396506=:9036
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0208150930051.9036@sp-home.isdn.scali.no>

Hi,

Here's just the patch related to the problem I reported yesterday. It's 
against 2.4.19, but I think it will apply to any of the latest 
2.4.20-pre2 trees.

Let's hope it gets included into the next -pre release.

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency


---1463795199-2053448221-1029396506=:9036
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pci-dma.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208150938100.9036@sp-home.isdn.scali.no>
Content-Description: 
Content-Disposition: attachment; filename="pci-dma.patch"

LS0tIGxpbnV4LTIuNC4xOS1vbGQvYXJjaC9pMzg2L2tlcm5lbC9wY2ktZG1h
LmMufjF+CVdlZCBBdWcgMTQgMTU6MDY6NDkgMjAwMg0KKysrIGxpbnV4LTIu
NC4xOS9hcmNoL2kzODYva2VybmVsL3BjaS1kbWEuYwlXZWQgQXVnIDE0IDE1
OjA4OjI5IDIwMDINCkBAIC0xOSw3ICsxOSw3IEBADQogCXZvaWQgKnJldDsN
CiAJaW50IGdmcCA9IEdGUF9BVE9NSUM7DQogDQotCWlmIChod2RldiA9PSBO
VUxMIHx8IGh3ZGV2LT5kbWFfbWFzayAhPSAweGZmZmZmZmZmKQ0KKwlpZiAo
aHdkZXYgPT0gTlVMTCB8fCBod2Rldi0+ZG1hX21hc2sgPCAweGZmZmZmZmZm
KQ0KIAkJZ2ZwIHw9IEdGUF9ETUE7DQogCXJldCA9ICh2b2lkICopX19nZXRf
ZnJlZV9wYWdlcyhnZnAsIGdldF9vcmRlcihzaXplKSk7DQogDQo=
---1463795199-2053448221-1029396506=:9036--
