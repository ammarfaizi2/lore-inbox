Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272240AbRIER1i>; Wed, 5 Sep 2001 13:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272242AbRIER11>; Wed, 5 Sep 2001 13:27:27 -0400
Received: from mx0.gmx.net ([213.165.64.100]:47840 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S272240AbRIER1T>;
	Wed, 5 Sep 2001 13:27:19 -0400
Date: Wed, 5 Sep 2001 19:27:35 +0200 (MEST)
From: pattreeya@gmx.net
To: dhinds@zen.stanford.edu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary8801999710855"
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0006447296@gmx.net
X-Authenticated-IP: [213.7.19.39]
Message-ID: <8801.999710855@www39.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary8801999710855
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Dear Sir,
       I have compiled kernel 2.4.8 on my machine (debian-woody) and during
I installed
       modules (make modules_install), the  message below concerning about
pcmcia occured.
This made me couldn't install other modules, I guess. (only kernel and
pcmcia directories found in 
/lib/modules/2.4.8/).
Threrefore, I switched off pcmcia support during configuration and
recompiled it three times with 
different
option for configuration. However, it didn't help. I can boot and mount file
with new kernel but 
cannot
install sound and other modules. Could you please give me some suggestion?


          Thank you so much in anticipation.

                                                Sincerely yours,
                                                Pattreeya Tanisaro.



make[1]: Entering directory `/usr/src/linux/arch/i386/math-emu'
make[1]: Für das Target »modules_install« gibt es nichts zu tun.
make[1]: Leaving directory `/usr/src/linux/arch/i386/math-emu'
cd /lib/modules/2.4.8; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.8; fi
judy:/usr/src/linux#



-- 
http://pgpkeys.mit.edu:11371/pks/lookup?op=get&search=pattreeya

GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

--========GMXBoundary8801999710855
Content-Type: application/octet-stream; name="

"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="
"

--========GMXBoundary8801999710855--

