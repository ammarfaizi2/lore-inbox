Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261716AbSJFSHF>; Sun, 6 Oct 2002 14:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbSJFSHF>; Sun, 6 Oct 2002 14:07:05 -0400
Received: from arago.euroconnect.fr ([195.132.14.158]:40362 "EHLO
	smtp.calixo.net") by vger.kernel.org with ESMTP id <S261716AbSJFSHD>;
	Sun, 6 Oct 2002 14:07:03 -0400
From: Rebert Luc <lucrebert@altern.org>
To: linux-kernel@vger.kernel.org
Subject: Is it a bug ?
Date: Sun, 6 Oct 2002 20:12:34 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YWNKO6I35IWAGYS7NVZ5"
Message-Id: <20021006180703Z261716-8740+7751@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_YWNKO6I35IWAGYS7NVZ5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hello,
I have try many times to compile a kernel 2.4.18 and 2.4.19 for my k6-2 (it 
is a desktop computer i don't need pcmia as a module or compiled in the 
kernel so i haven't stick it) but every time there si a bug when i make "make 
modules_install" I can see this bug !!!  Can you help me please ? I think 
it's a bug, what do you think about this ?

make[1]: Leaving directory `/usr/src/linux/arch/i386/mm'
make -C  arch/i386/lib modules_install
make[1]: Entering directory `/usr/src/linux/arch/i386/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
cd /lib/modules/2.4.18; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.18; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.18/kernel/fs/binfmt_elf.o
depmod: 	empty_zero_page
depmod: 	get_user_pages
make: *** [_modinst_post] Error 1

A big thanks !!!!

REBERT Luc


--------------Boundary-00=_YWNKO6I35IWAGYS7NVZ5
Content-Type: application/pgp-keys;
  name="my pgp key"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=public_key.asc

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdudVBHIHYxLjAu
NiAoR05VL0xpbnV4KQpDb21tZW50OiBGb3IgaW5mbyBzZWUgaHR0cDovL3d3dy5nbnVwZy5vcmcK
Cm1RR2lCRDJYS2kwUkJBRDRJcnJkN1B2L2F3cEVWb1FUQlowdmp0bVYrZHNwZCszYks3QlpoeHVs
c25IOGNDU3oKcVJwd2VYY2drU3ZJN2hHbE8yUlJlVExjTVhBU28zeCs3SFpDNENndjNqaWd6bThs
M1NkNVdoWVJOTTFJMjJjNQplQm5mRHdNVmxxdDJLdE9pdjU3ZVlnMGl6dnhVaDBoaDZTNHNxMGJ5
dm5pSjY0eWcrUDRSQ2NobEd3Q2dtR2ZLCkRFT0RNTjl2Z0dIK0NGSXlwRWpXL3I4RC8yanJvZlNr
dGN2YTNwa3dpV2RSVnROK2p2UmVYVzVRUTZnbFRUTEEKcGU5MHRNOElYSjNDK2Z3RlBkTnF2TFIz
eGxpTTVoUFBnOHdaQVljRGoyZlRwTk0yV05tNFVFQ3Jjd2RkWHBsaAp1MERXazhGTnNuR2VCNmY4
eVQ2Y241T3JFOWplWmRaNEpUWUlzenhJMGhoSWNJclVFdU11a3dGQTF3SGtGZzFWCml6a1hCQURY
VG1lckpJY0tjT25HK3JwbU9BUmRSRUYwcHJ2MCtVeERJd2hBYkpUK3FGVVNic1BjV2dRWks3WmMK
M3hEbWtOQzVIejIrQlVkVFEvbmJEOXYxVk83VkViZVFxOFhqTXFUeXBGY2pJVWRQQ2Z2TDNick9Z
TkFpS2pxSwo4WkpVUkVsMWxML0hsWGR6VnNEVUhFbS9KWHZJT1RodzJNUHNCUDUwMXhtVTFCRkxr
N1EwVW1WaVpYSjBJRXgxCll5QW9TU0JzYVd0bElFeHBiblY0SUM0dUxpa2dQR3gxWTNKbFltVnlk
RUJoYkhSbGNtNHViM0puUG9oWEJCTVIKQWdBWEJRSTlseW91QlFzSENnTUVBeFVEQWdNV0FnRUNG
NEFBQ2drUU45RUc0TlhVL0pvVVVBQ2RIRkIxUEkxNgo2TDJBZEZPNmg4aXZYMU5NamlRQW4wQ0J4
amVaOXdRNWpzUFJSMXowd2Z2TWNJeUdpRVlFRUJFQ0FBWUZBajJYCjhlb0FDZ2tRVGRGM3RUS3RJ
UFhCYVFDZVBzV3lIQUVtT01XaVB2cEF6SGlCdjBocU9wMEFuam5LQlVBa21kTG4KdlA5UkNFZVB6
M3RMZ2gzWHVRRU5CRDJYS2pZUUJBQ2Z6U1VHb3hCb21jMnluZHBLV3RGUm5UQTM5bFFTNWE4eQpt
K1VTZXR4RjhvSnNEZGNoTUhVU25UTXh4d0xpRzZiOUF3a0MrRFhFOXY3NHdFZkYxN2tjYXVEN1Qy
cjBxNFBLCnVjcFRFM1c4T0YvWFBrTUlMTW9WOWg0SjNDbEJmYlhMZndmWXR0b1BvdjE5SHNHTDQ1
K2RvWWswN0s1cGJOOEEKbklEZk12Qm1ld0FEQlFQK0xoRUxwUXpic0NEd21TR3ZDcjhBYWdQMWtL
VWhWUnpjek1wREo4M244SGFyODBTVwpsWVhiMW9yMVZWWklrcTdkdTBrdHQ4UFJqTkVINmxoQ21M
YTBmdnE1SnkybE1VVkVrTjdXYUQ2dlkzdjBNNnFqCkZOd1QyZERBK012NUpHdjAwaitTaDd5RDRj
dzZyN1orS3h4SFBraG1YdnJneEtaMkZqZFQ1ZHRqVHNpSVJnUVkKRVFJQUJnVUNQWmNxTmdBS0NS
QTMwUWJnMWRUOG1wMmFBSjlmTGxSTGhoSURPejU0cFdMdVFPc1Jzc2pZL0FDZQpLaWdUbDY5YjZm
ZVNUYjhUVU5KQlhrdjhkRjg9Cj1uckdZCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0t
LS0K

--------------Boundary-00=_YWNKO6I35IWAGYS7NVZ5--
