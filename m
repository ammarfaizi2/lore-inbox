Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbUAIVw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbUAIVw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:52:29 -0500
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:54801 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S264566AbUAIVwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:52:10 -0500
Date: Fri, 9 Jan 2004 23:50:41 +0100 (CET)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.1-mm1 and modular IDE.
Message-ID: <Pine.LNX.4.58L.0401092345370.9003@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1667897478-400618942-1073688641=:9003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1667897478-400618942-1073688641=:9003
Content-Type: TEXT/PLAIN; charset=US-ASCII

OK. I try to build 2.6.1 with and without -mm1 patch.
Both with options listed below.
in attachment are output logs.
they are identical - that means that modular IDE in 2.6.1-mm1 is broken.

Sorry.
					Sas.
P.S.
Or, ...
I'm so stupid, that I can't build kernel.

[...]

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_IDEDMA_PCI_WIP=y
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
CONFIG_BLK_DEV_CY82C693=m
CONFIG_BLK_DEV_CS5520=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
CONFIG_BLK_DEV_PDC202XX_NEW=m
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_IDE_CHIPSETS=y

#
# Note: most of these also require special kernel boot parameters
#
CONFIG_BLK_DEV_4DRIVES=y
CONFIG_BLK_DEV_ALI14XX=m
CONFIG_BLK_DEV_DTC2278=m
CONFIG_BLK_DEV_HT6560B=m
CONFIG_BLK_DEV_PDC4030=m
CONFIG_BLK_DEV_QD65XX=m
CONFIG_BLK_DEV_UMC8672=m
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

[...]

-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
---1667897478-400618942-1073688641=:9003
Content-Type: APPLICATION/x-bzip2; name="KLOG_mm.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58L.0401092350410.9003@alpha.zarz.agh.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="KLOG_mm.bz2"

QlpoOTFBWSZTWW2dE/YAAj1fgAAQYA//8DWnWoC/7//wYAh53z5xbipLEAaM
hVClmDXdjDQ0AAAGgAAAADDQ0AAAGgAAAABppoRqoBMAAIxDAE9E2gSaSiJP
TUyMymgaAAAAAE1UijNTaqfip5qTek9JMGk0BpjUAYKVFMgAQaCp6mQZGgyA
ZNNPTT/NGvo917H+4eTP+eO/Sq1M+KZJOi7uS7wQlCSdoy8GDdeWPjNZJJ0G
k5zh8GLebxNXQWHDkraa5s00xduYZaW0tumURHN/OToSAa79v9dn8fslDSJ6
ZSfij8sHxjjj5iejKpaon44lDK9ChxialDTZ89ql031C17wqz3BVjw1W0KsR
0xaXiKliIvYKlw/vr8Pv6d2zrr4a5+7t14eOdAd9ns2tOJxetdzJaVV4Sh8r
NREVMuAMnKTQg4d8ReczgXd3MlkQ4VJVVVIkohw7q7u5wLu7mTABhRVKZIcz
d3maGbu5kpYiQ2xs5ePZEWAq7e6bMU9fAKtgVZi86lNfaqGyrPDGKs4DUlMV
Q2khIMms2qipGMIgMFIoLBSKCgsUgsixSLAWRYKRSKCgoLIoJ75JAOBISG0J
rCQBhvxMfZVDMcMC1xLTXTFUNk8vGO/tFMzDMzKWmY5hclRV7MYB7DhrC+sl
T6CpqZkJ+l9y+k57h7168P5qUxVD+m6uq4Q6mOnAfWmi7w+ry34yxattG52I
eCSbtpygPSiit5EEDZAOMA1yR4SQCCAadIchPEBud3cYKqi9tZvyNZ5dPefM
3dhqMzfPwb8Ep+KouYVfMKu/yiL+gqxEXkFXpksRF/MRdQVeURafwFWgVfpE
Wkrm5WOOMvpjKdKmP1MFc23H0blTTdezXZttQ0fkjC+/W3H2VywmeUWlVfhn
PMMcueX37s3CowfnzyDZpYqY/hh9w/tVDSZo5T83Ty5VxMvHuvHjjWN2ku2m
OXD786TZc7+/2+fdSmevwO70nlyKHbyxVDXhuDgvaHbHZfbOPabk37+HXZJ1
YtmMeqiulUNOQR210WGW7YW9rt5zFaT4zhy1ic6oeuE6j8sTTdp3yx2Rl3Qp
12u3eYYFnYyDZmqGQuqlMaKhnSJ0qpeXVjDn5ZtmNmEUxCjy2BD+wIcxIc2d
XUx0URbKDnKj0qhgkbPOqHtN+icsE3YoP06M1HucsXReKof726RMbXD1VDsq
Gy4VyblVpITG3dnxd8MO9w06g2QYxaeCVLsCrqiLBg5ccZZZN8Rdu41tsqzz
qdh1rW4tNdy53G6bDlTZZA1icd76fNUNoYDtoKxiSdPMyKec2KUz22C8bh84
SxglMHBgxWMF8YZAxYYxQ3VQ3VmJxrWeoR5cq7V0vZ555mtUPQ8aNV6M7SDz
cb7eWQo0zCresdlr3JUZ3lD8BU31zKHtITltnGqHVLHoXJSy2bjOIuS5ZxFg
wFW3xE0etttzxVDhXQetLNdsz6ihu9B1naqG6w4dlKcummr4KGN2tpVDsqHW
QmztW1zKGfaJ8lDppU6DG23MVQ1Se8TCoZ8uKLp/yliIu/z0VcJeAVa2WgVd
BPu2+iTY53c9u7nE9q9OHUOFx9+134FDzWqT38QY7Sh6RTCM7czbVVac9ml6
TIrOwwzbxiuNtaabcIu3DltyJJEdA55kCG/BFRERVVVVVVVVVVCGk2SdBxkg
SbJMA0hAIckMrjVDjaSE1wrRpfGy8sNMW9UN7n8ZwtFKdZCcpqXUcHJdfLO3
r5tdtUNayhvZLa1zOO4PnVVZuGuq9Ch9NvK5+3DvV42NwdJzeeeLDn221Vyc
Tvemlr2iZbbvLK3vPCHJziZ+t8CVmCcGm6ireLu4Krb1qlZt4hjkFtwpTnWN
ZzFnTNZqhw2kwApmkc+6zMwA6R6jNpkSEkAkkyCSAQWZ85GAOlfM2lttpbYB
whu7W+8TQJgaY8FD9Nt/8XckU4UJBtnRP2A=

---1667897478-400618942-1073688641=:9003
Content-Type: APPLICATION/x-bzip2; name="KLOG_no_mm.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58L.0401092350411.9003@alpha.zarz.agh.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="KLOG_no_mm.bz2"

QlpoOTFBWSZTWeVxVgEAAkBfgAAQYA//8DWnWoC/7//wYAh7d75cZyXbQakG
mgAFMjQ2MNDQAAAaAAAAAGqeGpmqo0ABoAAAAADHsoiDTBAaMjE00AA0YBJp
KTSjNTEwmjJoAxAAaAEVAinmlPTRqn6JN6kB6jahgg09Q0ClRCNCYgTTQptQ
aAyaGJoD1byqyVfj8Tm2Fov6FdbS1iwdyySQUACIApGCVEl8pt5aWWPKvq8W
zM3w2IdrT3bmXKo4WBFOHZW02Zrppi7cwy0tpbdMoiObuEnGkAp0Wd0u3iKg
TQTOIifsQ5wDqhfD1oJmRalsifphUMr0lDnE2lDXT5d4nz6xU6e4RpzCMfTp
OIRhXzgdBxQQSCop70EEx5019nXusoHbWXx21x4yEh31OnV/aNLMkS2RjCqI
l7i8TM4JcAW1xGUwHDvUq7NBJIlsoYOIqpmqqiC0MHDvCSRoJJEtIDTE4xBL
B2KSs4FpIloipIy7d8/byqUwEeXmuGC/X2COARpU9qlNvYI0qzyxirOA2kpg
IayQkGTZNqoqRjCIDBSKCwUigoLFILIsWRYCyLBSKWMGMGMGMVjBh94R61Kc
S2VDCN8TH2hGY5YFtiWu2uAjSeXweL3CmZhmZlLTMcwuSoq+CJA7Tl2QvJRU
1QVKBFUBPR5DqmFoHBfVd9VVMBH3ca7LkjsY68h9U1Xij7PLfGRtW2jc78Om
Sb203wHkRRW95BA1gPhDbSsesRMBr6G6+o545+2JjGMYwxjvtN8jaeXX4z5T
j3GwzN5+DfElP0qU+IR/gI9/yqU/QIxUp+QR+pJipT/NSmoR+VSm/5hG4R91
Sm6PjejHfGfxxlfMWPvrFHBshqWipO13lJWNECZzEID30bQ4gVgLPSLUD8M5
8IY6eGX9eObkJg/54ZBpqwVIfOByA8QBCaRUKp/Tp21W8ImnAdNL1hbNHZOF
bu+M0k4Pl8t2SopHHqAyM021Sh38sBG3LjDkvZHfHdfvnPvOKb78u2knZi0x
j1ErqEa9IR321WGXHQt23DwmK1nvnDptE8Aj1wnYf6xNeOvjljvRl4kU7cHf
xmGBZ0ZBpkIyF2qUxrVDOsTqCvLsxh4eWbRxIpiFHfsCH9gQ4CQ4M5+djooi
2ZMZyo9AjEkaeYR7TfVOmCccEP/dWaj4nTF1XwCPz4axMcHL1qQNiqBJuWpa
qs1QEhZbHRygQMm6eIXCqsYb/SoTkEa1KYrFenfGc5utSnlzro4oaaC5DadH
e36c58Xd8+FeiaWYG0Tnu+nyCOEMB31FYwpOvmZinnNKlM99BfDiPlhLGJKY
OTBisYL3wzAxYYxQ4hHGsxOdbT1hHl0rvXW9nnnwNgj0PhrdJ8tG9Vevd4+m
RK30COsxydPOoTO8ofhFTevCUPaoTpwnMI1THynpEzw51pUp6T00qUxWAjh8
Imr1uFxfAI5V1HrSzXfM+yUOPoO07hHGw5d6lOnXXZ7yhjjtahHeqHaoTTuO
DwlDPtE+UoddanUY4XFgI2SfGJiqGfLnQ+f/YmKlPf2lDsn0COjO4EOtBOVm
YiSMHIN+Rggm9c7sUC5v4bHx5Sh5rZJ8fhBjuqHolMUZ4ZnAI3+PDd+qsk0Y
sWl1qwd3G3344lPCzk22SSI6BwzIEN2CKiIiqqqqqqqqqrCGk1k4zmAhJrJg
GkkJ0oZXMI52tQm2Fatb30vLDXFvVDd4e+cLWpTtUJ0mxdhydF28s8O3m24B
G1ZQ3ZLg2zOfGHy2qmLdSg5ooGtlXDfdkrpItQOlMDdG8gYbLAHRzPG9Nbbv
Ey4XjLK3eeEOjwiZ+r3hGgK7W/OUOtTz7QcdkRpdQjHQLhipTwrG08BZ1yMh
HLhKHCtn19Qj9j8W/LS0xhppoaaaaWjMwMMzPpIkB0r6m0tttLaQOWG9xbrz
EwZBOGiKB6WP/F3JFOFCQ5XFWAQ=

---1667897478-400618942-1073688641=:9003--
